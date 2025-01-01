import "package:country_utils/src/localization/country_localizations.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

extension WidgetTesterExtension on WidgetTester {
  /// Pump a localized [widget].
  Future<void> pumpLocalizedWidget(
    Widget widget, {
    String locale = "en",
    ThemeMode themeMode = ThemeMode.light,
    ThemeData? theme,
  }) =>
      pumpWidget(
        MaterialApp(
          localizationsDelegates: List.empty(growable: true)
            ..add(CountryLocalizations.delegate),
          themeMode: themeMode,
          theme: theme,
          locale: Locale(locale),
        ),
      );
}

/// Load the l10n class
Future<CountryLocalizations> setupLocalizations([String locale = "en"]) async =>
    CountryLocalizations.delegate.load(Locale(locale));
