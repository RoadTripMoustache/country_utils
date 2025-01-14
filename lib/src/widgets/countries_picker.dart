library country_code_picker;

import 'package:collection/collection.dart' show IterableExtension;
import "package:country_utils/country_utils.dart";
import "package:country_utils/src/models/country.dart";
import "package:country_utils/src/widgets/selection_multi_dialog.dart";
import "package:country_utils/src/widgets/selection_single_dialog.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CountriesPicker extends StatefulWidget {
  final ValueChanged<List<Country>>? onChanged;
  final ValueChanged<List<Country>>? onInit;
  final List<String> initialSelection;
  final List<String> favorite;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? dialogTextStyle;
  final WidgetBuilder? emptySearchBuilder;
  final Function(List<Country>)? builder;
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

  CountriesPicker({
    this.onChanged,
    this.onInit,
    this.initialSelection = const [],
    this.favorite = const [],
    this.textStyle,
    this.selectedTextStyle,
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
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print("this.initialSelection :::: ${this.initialSelection}");
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

    return CountriesPickerState(elements);
  }
}

class CountriesPickerState extends State<CountriesPicker> {
  List<Country> selectedItems = [];
  List<Country> elements = [];
  List<Country> favoriteElements = [];

  CountriesPickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        onTap: showCountryPickerDialog,
        child: widget.builder!(selectedItems),
      );
    else {
      _widget = TextButton(
        onPressed: widget.enabled ? showCountryPickerDialog : null,
        child: Padding(
          padding: widget.padding,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (selectedItems.isEmpty)
                Text(
                  "Choose a country",
                  style: TextStyle(color: Colors.white70),
                ),
              if (selectedItems.isNotEmpty &&
                  (widget.showFlagMain != null
                      ? widget.showFlagMain!
                      : widget.showFlag))
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
                      countryCode: selectedItems[0].isoCodeAlpha2,
                      width: widget.flagWidth,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (selectedItems.isNotEmpty && !widget.hideMainText)
                Flexible(
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Text(
                    selectedItems[0].name,
                    style: widget.textStyle ??
                        Theme.of(context).textTheme.bodyMedium,
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
    return _widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _onInit(selectedItems);
  }

  @override
  void didUpdateWidget(CountriesPicker oldWidget) {
    print("didUpdateWidget 00 :: $selectedItems");
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection.isNotEmpty) {
        selectedItems = elements.where(
          (e) {
            bool isSelected = false;
            for (final element in widget.initialSelection) {
              if (element.toUpperCase() == e.isoCodeAlpha2.toUpperCase() ||
                  element.toUpperCase() == e.isoCodeAlpha3.toUpperCase() ||
                  element.toUpperCase() == e.dialCode.toUpperCase() ||
                  element.toUpperCase() == e.name.toUpperCase()) {
                isSelected = true;
                break;
              }
            }
            return isSelected;
          },
        ).toList();
        print("didUpdateWidget 1 :: $selectedItems");
      } else {
        selectedItems = [];
        print("didUpdateWidget 2 :: $selectedItems");
      }
      _onInit(selectedItems);
    }
    print("didUpdateWidget :: $selectedItems");
  }

  @override
  void initState() {
    print(">>> widget.initialSelection :: ${widget.initialSelection}");
    super.initState();

    if (widget.initialSelection.isNotEmpty) {
      selectedItems = elements.where(
        (e) {
          bool isSelected = false;
          for (final element in widget.initialSelection) {
            if (element.toUpperCase() == e.isoCodeAlpha2.toUpperCase() ||
                element.toUpperCase() == e.isoCodeAlpha3.toUpperCase() ||
                element.toUpperCase() == e.dialCode.toUpperCase() ||
                element.toUpperCase() == e.name.toUpperCase()) {
              isSelected = true;
              break;
            }
          }
          return isSelected;
        },
      ).toList();
      print("initState 1 :: $selectedItems");
    } else {
      selectedItems = [];
      print("initState 2 :: $selectedItems");
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
    print("initState :: $selectedItems");
  }

  // TODO DOC README
  // TODO CHANGELOG
  void showCountryPickerDialog() {
    print("showCountryPickerDialog :: $selectedItems");
    showDialog(
      barrierColor: widget.barrierColor ?? Colors.black.withOpacity(0.2),
      // backgroundColor: widget.backgroundColor ?? Colors.transparent,
      context: context,
      builder: (context) => Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: 500, maxWidth: 400),
          child: Dialog(
            child: SelectionMultiDialog(
              List.of(elements),
              List.of(selectedItems),
              List.of(favoriteElements),
              showCountryOnly: widget.showCountryOnly,
              emptySearchBuilder: widget.emptySearchBuilder,
              searchDecoration: widget.searchDecoration,
              searchStyle: widget.searchStyle,
              textStyle: widget.dialogTextStyle,
              selectedTextStyle: widget.selectedTextStyle,
              boxDecoration: widget.boxDecoration,
              showFlag: widget.showFlagDialog != null
                  ? widget.showFlagDialog
                  : widget.showFlag,
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
      print("RECEIVE DATA :: $e");
      if (e != null) {
        setState(() {
          selectedItems = e;
          print("open diagog 1 :: $selectedItems");
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(List<Country> e) {
    if (widget.onChanged != null) {
      widget.onChanged!(e);
    }
  }

  void _onInit(List<Country> e) {
    if (widget.onInit != null) {
      widget.onInit!(e);
    }
  }
}
