// ignore_for_file: avoid_field_initializers_in_const_classes
import "package:country_utils/src/exceptions/country_not_found_exception.dart";
import "package:country_utils/src/models/country.dart";
import "package:country_utils/src/services/country_service.dart";
import "package:flutter/material.dart";

/// Widget to display the flag of a country based on the [countryCode].
///
/// If no flag where found a [CountryNotFoundException] will be thrown.
class RTMCountryFlag extends StatelessWidget {
  /// ISO code of the country which we want to display the flag.
  ///
  /// The ISO code can be the 2 letters one or the 3 letters one.
  late final String countryCode;

  /// Width of the image.
  ///
  /// If none of the width and height are defined, the image will keep its
  /// original size.
  /// If only the width is defined, the height will be automatically scaled.
  /// If only the height is defined, the width will be automatically scaled.
  final double? width;

  /// Height of the image.
  ///
  /// If none of the width and height are defined, the image will keep its
  /// original size.
  /// If only the width is defined, the height will be automatically scaled.
  /// If only the height is defined, the width will be automatically scaled.
  final double? height;

  /// Defines how the image must fit if the box size isn't a scale of the
  /// original size. Default `BoxFit.none`.
  final BoxFit fit;

  RTMCountryFlag({
    required String countryCode,
    this.width,
    this.height,
    this.fit = BoxFit.none,
    super.key,
  }) {
    // Search for the country by its code to have more flexibility on the kind
    // of code used.
    final Country? country = CountryService.getCountryByCode(countryCode);

    if (country == null) {
      throw CountryNotFoundException(
        "No country where found with the code $countryCode",
      );
    }
    this.countryCode = CountryService.getCountryByCode(countryCode)!
        .isoCodeAlpha2
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) => Image.asset(
        "assets/flags/$countryCode.png",
        package: "country_utils",
        width: width,
        height: height,
        fit: fit,
      );
}
