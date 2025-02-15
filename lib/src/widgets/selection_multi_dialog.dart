import "package:country_utils/country_utils.dart";
import "package:diacritic/diacritic.dart";
import "package:flutter/material.dart";

/// Selection dialog used for selection of the multiple countries.
class RTMSelectionMultiDialog extends StatefulWidget {
  final List<Country> elements;
  final List<Country> selected;
  final bool? showCountryOnly;
  late final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final BoxDecoration? boxDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final bool? showFlag;
  final double flagWidth;
  final Decoration? flagDecoration;
  final Size? size;
  final bool hideSearch;
  final Icon? closeIcon;

  /// Background color of SelectionDialog
  final Color? backgroundColor;

  /// BoxShadow color of SelectionDialog that matches CountryCodePicker barrier
  /// color
  final Color? barrierColor;

  /// elements passed as favorite
  final List<Country> favoriteElements;

  /// [ButtonStyle] of the confirmation button in the dialog.
  final ButtonStyle? confirmButtonStyle;

  /// [Widget] to put in the confirmation button.
  final Widget? confirmationButtonContent;

  RTMSelectionMultiDialog(
    this.elements,
    this.selected,
    this.favoriteElements, {
    super.key,
    this.showCountryOnly,
    this.emptySearchBuilder,
    InputDecoration searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.textStyle,
    this.selectedTextStyle,
    this.boxDecoration,
    this.showFlag,
    this.flagDecoration,
    this.flagWidth = 32,
    this.size,
    this.backgroundColor,
    this.barrierColor,
    this.hideSearch = false,
    this.closeIcon,
    this.confirmButtonStyle,
    this.confirmationButtonContent,
  }) {
    this.searchDecoration = searchDecoration.prefixIcon == null
        ? searchDecoration.copyWith(prefixIcon: Icon(Icons.search))
        : searchDecoration;
  }

  @override
  State<StatefulWidget> createState() => _RTMSelectionMultiDialogState();
}

class _RTMSelectionMultiDialogState extends State<RTMSelectionMultiDialog> {
  /// Current list of elements filtered with the input selection.
  late List<Country> filteredElements;

  /// Updated list of selected countries before submission.
  late List<Country> updatedSelection;

  @override
  Widget build(BuildContext context) {
    final String selectionLabel =
        CountryLocalizations.of(context)?.translate("selected_countries") ??
            "Selected countries";
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: widget.size?.width ?? MediaQuery.of(context).size.width,
        height:
            widget.size?.height ?? MediaQuery.of(context).size.height * 0.85,
        decoration: widget.boxDecoration ??
            BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: widget.barrierColor ?? Colors.black.withAlpha(220),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 20,
              icon: widget.closeIcon!,
              onPressed: () => Navigator.pop(context),
            ),
            if (!widget.hideSearch)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  style: widget.searchStyle,
                  decoration: widget.searchDecoration,
                  onChanged: _filterElements,
                ),
              ),
            Expanded(
              child: ListView(
                children: [
                  if (widget.selected.isEmpty)
                    const DecoratedBox(decoration: BoxDecoration())
                  else
                    ExpansionTile(
                      title: Text(
                        "$selectionLabel (${widget.selected.length})",
                        style: TextStyle(fontSize: 16),
                      ),
                      shape: Border.all(color: Colors.transparent),
                      controlAffinity: ListTileControlAffinity.leading,
                      children: <Widget>[
                        ...widget.selected.map(
                          (f) => SimpleDialogOption(
                            child: _buildOption(f, isSelected: true),
                            onPressed: () {
                              _unselectItem(f);
                            },
                          ),
                        ),
                      ],
                    ),
                  const Divider(),
                  if (widget.favoriteElements.isEmpty)
                    const DecoratedBox(decoration: BoxDecoration())
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...widget.favoriteElements.map(
                          (f) => SimpleDialogOption(
                            child: _buildOption(f),
                            onPressed: () {
                              _selectItem(f);
                            },
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  if (filteredElements.isEmpty)
                    _buildEmptySearchWidget(context)
                  else
                    ...filteredElements.map(
                      (e) {
                        final bool isSelected = _isSelected(e);
                        return SimpleDialogOption(
                          child: _buildOption(e, isSelected: isSelected),
                          onPressed: () {
                            if (isSelected) {
                              _unselectItem(e);
                            } else {
                              _selectItem(e);
                            }
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: FilledButton(
                    style: widget.confirmButtonStyle,
                    onPressed: () {
                      Navigator.pop(context, updatedSelection);
                    },
                    child: widget.confirmationButtonContent ?? Text("OK")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(Country e, {bool isSelected = false}) => SizedBox(
        width: 400,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            if (widget.showFlag!)
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  decoration: widget.flagDecoration,
                  clipBehavior:
                      widget.flagDecoration == null ? Clip.none : Clip.hardEdge,
                  child: RTMCountryFlag(
                    fit: BoxFit.fill,
                    countryCode: e.isoCodeAlpha2,
                    width: widget.flagWidth,
                  ),
                ),
              ),
            Expanded(
              flex: 4,
              child: Text(
                widget.showCountryOnly! ? e.isoCodeAlpha3 : e.name,
                overflow: TextOverflow.fade,
                style: isSelected ? widget.selectedTextStyle : widget.textStyle,
              ),
            ),
            if (isSelected) Icon(Icons.check_rounded),
          ],
        ),
      );

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(
      child: Text(CountryLocalizations.of(context)?.translate("no_country") ??
          "No country found"),
    );
  }

  @override
  void initState() {
    updatedSelection = widget.selected;
    updatedSelection.sort(
      (a, b) => removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
    );
    filteredElements =
        widget.elements.where((c) => !updatedSelection.contains(c)).toList();
    filteredElements.sort(
      (a, b) => removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
    );
    super.initState();
  }

  void _filterElements(String s) {
    final String upperS = s.toUpperCase();
    setState(() {
      filteredElements = widget.elements
          .where((e) =>
              e.isoCodeAlpha2.toUpperCase().contains(upperS) ||
              e.isoCodeAlpha3.toUpperCase().contains(upperS) ||
              e.dialCode.toUpperCase().contains(upperS) ||
              e.name.toUpperCase().contains(upperS))
          .toList();
      filteredElements.sort(
        (a, b) => removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
      );
    });
  }

  bool _isSelected(Country c) {
    bool isSelected = false;
    for (final element in updatedSelection) {
      if (!isSelected && element.name.toUpperCase() == c.name.toUpperCase()) {
        isSelected = true;
      }
    }
    return isSelected;
  }

  void _selectItem(Country e) {
    setState(() {
      updatedSelection
        ..add(e)
        ..sort(
          (a, b) =>
              removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
        );
      filteredElements.sort(
        (a, b) => removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
      );
    });
  }

  void _unselectItem(Country e) {
    setState(() {
      updatedSelection
        ..remove(e)
        ..sort(
          (a, b) =>
              removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
        );
      filteredElements.sort(
        (a, b) => removeDiacritics(a.name).compareTo(removeDiacritics(b.name)),
      );
    });
  }
}
