library country_code_picker;

import 'package:collection/collection.dart' show IterableExtension;
import "package:country_utils/country_utils.dart";
import "package:country_utils/src/models/country.dart";
import "package:country_utils/src/widgets/selection_single_dialog.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CountryPicker extends StatefulWidget {
  final ValueChanged<Country>? onChanged;
  final ValueChanged<Country?>? onInit;
  final String? initialSelection;
  final List<String> favorite;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? dialogTextStyle;
  final WidgetBuilder? emptySearchBuilder;
  final Function(Country?)? builder;
  final bool enabled;
  final TextOverflow textOverflow;
  final Icon closeIcon;

  /// Barrier color of ModalBottomSheet
  final Color? barrierColor;

  /// Background color of ModalBottomSheet
  final Color? backgroundColor;

  /// BoxDecoration for dialog
  final BoxDecoration? boxDecoration;

  /// the size of the selection dialog
  final Size? dialogSize;

  /// Background color of selection dialog
  final Color? dialogBackgroundColor;

  /// used to customize the country list
  final List<String>? countryFilter;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  final bool hideMainText;

  final bool? showFlagMain;

  final bool? showFlagDialog;

  /// Width of the flag images
  final double flagWidth;

  /// Use this property to change the order of the options
  final Comparator<Country>? comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  /// Set to true if you want to show drop down button
  final bool showDropDownButton;

  /// [BoxDecoration] for the flag image
  final Decoration? flagDecoration;

  /// An optional argument for injecting a list of countries
  /// with customized codes.
  final List<Country>? countryList;
  final ButtonStyle? textButtonStyle;

  CountryPicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.alignLeft = false,
    this.showFlag = true,
    this.showFlagDialog,
    this.hideMainText = false,
    this.showFlagMain,
    this.flagDecoration,
    this.builder,
    this.flagWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.barrierColor,
    this.backgroundColor,
    this.boxDecoration,
    this.comparator,
    this.countryFilter,
    this.hideSearch = false,
    this.showDropDownButton = false,
    this.dialogSize,
    this.dialogBackgroundColor,
    this.closeIcon = const Icon(Icons.close),
    this.countryList,
    this.textButtonStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    List<Country> elements = List.empty(growable: true);

    if (countryList != null) {
      elements.addAll(countryList!);
    }
    elements.addAll(CountryService.getCountries());

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (countryFilter != null && countryFilter!.isNotEmpty) {
      final uppercaseCustomList =
      countryFilter!.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
      uppercaseCustomList.contains(c.isoCodeAlpha2) ||
          uppercaseCustomList.contains(c.isoCodeAlpha3) ||
          uppercaseCustomList.contains(c.name) ||
          uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return CountryPickerState(elements);
  }
}

class CountryPickerState extends State<CountryPicker> {
  Country? selectedItem;
  List<Country> elements = [];
  List<Country> favoriteElements = [];

  CountryPickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget builtWidget;
    if (widget.builder != null) {
      builtWidget = InkWell(
        onTap: showCountryPickerDialog,
        child: widget.builder!(selectedItem),
      );
    } else {
      builtWidget = TextButton(
        style: widget.textButtonStyle,
        onPressed: widget.enabled ? showCountryPickerDialog : null,
        child: Padding(
          padding: widget.padding,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.showFlagMain != null
                  ? widget.showFlagMain!
                  : widget.showFlag)
                Flexible(
                  flex: widget.alignLeft ? 0 : 1,
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Container(
                    clipBehavior: widget.flagDecoration == null
                        ? Clip.none
                        : Clip.hardEdge,
                    decoration: widget.flagDecoration,
                    margin: widget.alignLeft
                        ? const EdgeInsets.only(right: 16.0, left: 8.0)
                        : const EdgeInsets.only(right: 16.0),
                    child: RTMCountryFlag(
                      countryCode: selectedItem!.isoCodeAlpha2,
                      width: widget.flagWidth,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (!widget.hideMainText)
                Flexible(
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Text(
                    selectedItem!.name,
                    style: widget.textStyle ??
                        Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,
                    overflow: widget.textOverflow,
                  ),
                ),
              if (widget.showDropDownButton)
                Flexible(
                  flex: widget.alignLeft ? 0 : 1,
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Padding(
                      padding: widget.alignLeft
                          ? const EdgeInsets.only(right: 16.0, left: 8.0)
                          : const EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                        size: widget.flagWidth,
                      )),
                ),
            ],
          ),
        ),
      );
    }
    return builtWidget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(CountryPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
                (e) =>
            (e.isoCodeAlpha2.toUpperCase() ==
                widget.initialSelection!.toUpperCase()) ||
                (e.isoCodeAlpha3.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()),
            orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
              (e) =>
          (e.isoCodeAlpha2.toUpperCase() ==
              widget.initialSelection!.toUpperCase()) ||
              (e.isoCodeAlpha3.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name.toUpperCase() == widget.initialSelection!.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
    widget.favorite.firstWhereOrNull((f) =>
    e.isoCodeAlpha2.toUpperCase() == f.toUpperCase() ||
        e.isoCodeAlpha3.toUpperCase() == f.toUpperCase() ||
        e.dialCode == f ||
        e.name.toUpperCase() == f.toUpperCase()) !=
        null)
        .toList();
  }

  void showCountryPickerDialog() {
    showDialog(
      barrierColor: widget.barrierColor ?? Colors.grey.withOpacity(0.5),
      // backgroundColor: widget.backgroundColor ?? Colors.transparent,
      context: context,
      builder: (context) =>
          Center(
            child: Container(
              constraints: BoxConstraints(maxHeight: 500, maxWidth: 400),
              child: Dialog(
                child: SelectionSingleDialog(
                  elements,
                  favoriteElements,
                  showCountryOnly: widget.showCountryOnly,
                  emptySearchBuilder: widget.emptySearchBuilder,
                  searchDecoration: widget.searchDecoration,
                  searchStyle: widget.searchStyle,
                  textStyle: widget.dialogTextStyle,
                  boxDecoration: widget.boxDecoration,
                  showFlag: widget.showFlagDialog ?? widget.showFlag,
                  flagWidth: widget.flagWidth,
                  size: widget.dialogSize,
                  backgroundColor: widget.dialogBackgroundColor,
                  barrierColor: widget.barrierColor,
                  hideSearch: widget.hideSearch,
                  closeIcon: widget.closeIcon,
                  flagDecoration: widget.flagDecoration,
                ),
              ),
            ),
          ),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(Country e) {
    widget.onChanged?.call(e);
  }

  void _onInit(Country? e) {
    widget.onInit?.call(e);
  }
}
