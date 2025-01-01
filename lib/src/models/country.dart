import "package:country_utils/src/enums/country_data.dart";

/// Model of a country.
class Country {
  /// The localized name of the country.
  String name;

  /// ISO 3166-1 Alpha-2 code of a country. This code is a 2 characters code
  /// representing the country.
  ///
  /// Reference : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
  final String isoCodeAlpha2;

  /// ISO 3166-1 Alpha-4 code of a country. This code is a 3 characters code
  /// representing the country.
  ///
  /// Reference : https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
  final String isoCodeAlpha3;

  /// Calling code to use to call someone in that country.
  ///
  /// Reference : https://en.wikipedia.org/wiki/List_of_country_calling_codes
  final String dialCode;

  Country({
    required this.name,
    required this.isoCodeAlpha2,
    required this.isoCodeAlpha3,
    required this.dialCode,
  });

  factory Country.data(CountryData data, String localizedName) => Country(
        name: localizedName,
        dialCode: data.callingCode,
        isoCodeAlpha2: data.isoCodeAlpha2,
        isoCodeAlpha3: data.isoCodeAlpha3,
      );

  @override
  String toString() => "[$isoCodeAlpha2] $name";
}
