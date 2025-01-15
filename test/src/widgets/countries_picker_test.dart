import "package:country_utils/country_utils.dart";
import "package:country_utils/src/services/cache_service.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "../../dummies/dummy_localized_strings.dart";

void main() {
  group("RTMCountriesPicker", () {
    group("UI", () {
      testWidgets("With default configuration", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RTMCountriesPicker(),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountriesPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(1));
        final widgetFlag = find.byType(RTMCountryFlag);
        expect(widgetFlag, findsNothing);
        final widgetText = find.text("Select a country");
        expect(widgetText, findsNWidgets(1));
      });
      testWidgets("With default selection", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RTMCountriesPicker(
              initialSelection: ["FR"],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountriesPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(1));
        final widgetFlag = find.byType(RTMCountryFlag);
        expect(widgetFlag, findsNWidgets(1));
        final widgetCountry = find.text("France");
        expect(widgetCountry, findsNWidgets(1));
        final widgetText = find.text("Select a country");
        expect(widgetText, findsNothing);
      });
      testWidgets("With multiple countries as default selection",
          (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RTMCountriesPicker(
              initialSelection: ["FR", "JP", "CA"],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountriesPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(1));
        final widgetFlag = find.byType(RTMCountryFlag);
        expect(widgetFlag, findsNWidgets(1));
        final widgetCountry = find.text("Canada");
        expect(widgetCountry, findsNWidgets(1));
        final widgetAdditionalCountries = find.text(" (+ 2)");
        expect(widgetAdditionalCountries, findsNWidgets(1));
        final widgetText = find.text("Select a country");
        expect(widgetText, findsNothing);
      });
      testWidgets("With placeholder", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RTMCountriesPicker(
              placeholder: Text("COUNTRY"),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountriesPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(1));
        final widgetPlaceholder = find.text("COUNTRY");
        expect(widgetPlaceholder, findsNWidgets(1));
        final widgetText = find.text("Select a country");
        expect(widgetText, findsNothing);
      });
      testWidgets("With builder", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: RTMCountriesPicker(
                builder: (List<Country> countryList) => Text("COUNTRIES"),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountriesPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(0));
        final widgetInkWell = find.byType(InkWell);
        expect(widgetInkWell, findsNWidgets(1));
        final widgetPlaceholder = find.text("COUNTRIES");
        expect(widgetPlaceholder, findsNWidgets(1));
        final widgetText = find.text("Select a country");
        expect(widgetText, findsNothing);
      });
    });
  });
}
