import "dart:convert";

import "package:country_utils/src/services/cache_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

/// Localization for the library. Helps to automatically manage the locale
/// from the app which use the library.
class CountryLocalizations {
  static const LocalizationsDelegate<CountryLocalizations> delegate =
      _CountryLocalizationsDelegate();

  final Locale locale;
  late Map<String, String> _localizedStrings;

  CountryLocalizations(this.locale);

  static CountryLocalizations? of(BuildContext context) =>
      Localizations.of<CountryLocalizations>(
        context,
        CountryLocalizations,
      );

  /// Load the correct i18n file matching the [locale] of the user.
  Future<bool> load() async {
    final String jsonString = await rootBundle.loadString(
        "packages/country_utils/assets/i18n/${locale.languageCode}.json");
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(
          key,
          value.toString(),
        ));
    CacheService.updateLocalizedStrings(_localizedStrings);

    return true;
  }

  /// Retrieve the i18n value of the [key].
  String? translate(String? key) => _localizedStrings[key!];
}

class _CountryLocalizationsDelegate
    extends LocalizationsDelegate<CountryLocalizations> {
  const _CountryLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
      "af",
      "am",
      "ar",
      "az",
      "be",
      "bg",
      "bn",
      "bs",
      "ca",
      "cs",
      "da",
      "de",
      "el",
      "en",
      "es",
      "et",
      "fa",
      "fi",
      "fr",
      "gl",
      "ha",
      "he",
      "hi",
      "hr",
      "hu",
      "hy",
      "id",
      "is",
      "it",
      "ja",
      "ka",
      "kk",
      "km",
      "ko",
      "ku",
      "ky",
      "lt",
      "lv",
      "mk",
      "ml",
      "mn",
      "ms",
      "nb",
      "nl",
      "nn",
      "no",
      "pl",
      "ps",
      "pt",
      "ro",
      "ru",
      "sd",
      "sk",
      "sl",
      "so",
      "sq",
      "sr",
      "sv",
      "ta",
      "tg",
      "th",
      "tr",
      "tt",
      "ug",
      "uk",
      "ur",
      "uz",
      "vi",
      "zh",
    ].contains(locale.languageCode);

  @override
  Future<CountryLocalizations> load(Locale locale) async {
    final CountryLocalizations localizations = CountryLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_CountryLocalizationsDelegate old) => false;
}
