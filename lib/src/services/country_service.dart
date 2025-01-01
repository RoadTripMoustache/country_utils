import "package:country_utils/src/models/country.dart";
import "package:country_utils/src/services/cache_service.dart";

/// Service which manages countries.
class CountryService {
  /// Retrieve the country with the [countryCode] given in parameter.
  ///
  /// It can be the ISO code Alpha 2 or 3 which can be used.
  /// If no countries are find, returns `null`.
  static Country? getCountryByCode(String countryCode) => CacheService.countries
      .where(
        (country) =>
            country.isoCodeAlpha2 == countryCode.toUpperCase() ||
            country.isoCodeAlpha3 == countryCode.toUpperCase(),
      )
      .firstOrNull;

  /// Returns the list of countries.
  static List<Country> getCountries() => CacheService.countries;
}
