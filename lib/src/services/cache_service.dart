import "package:country_utils/src/enums/country_data.dart";
import "package:country_utils/src/exceptions/localization_not_loaded_exception.dart";
import "package:country_utils/src/models/country.dart";

/// Used to store some information shared between services.
///
/// **This service must stay internal.**
class CacheService {
  /// Map of the localized country names.
  ///
  /// Key : ISO code alpha 2
  /// Value : Name of the country in the current locale
  static Map<String, String>? _localizedStrings;

  /// List of the countries built with the current locale values.
  static List<Country> _countries = List.empty();

  static Map<String, String>? get localizedStrings {
    _validateCache();
    return _localizedStrings;
  }

  static List<Country> get countries {
    _validateCache();
    return _countries;
  }

  /// Update the cached [localizedStrings] and build the [countries] list with
  /// the new localized names.
  static void updateLocalizedStrings(Map<String, String> localizedStrings) {
    _localizedStrings = localizedStrings;
    _countries = CountryData.values
        .map(
          (data) => Country.data(data, _localizedStrings![data.name]!),
        )
        .toList();
  }

  /// Validate if the cache is ready to be used. If not throws a
  /// [LocalizationNotLoadedException].
  static void _validateCache() {
    if (_localizedStrings == null || _countries.isEmpty) {
      throw LocalizationNotLoadedException(
        "CountryLocalizations is not correctly loaded.",
      );
    }
  }
}
