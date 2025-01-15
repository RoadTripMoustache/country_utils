import "package:country_utils/country_utils.dart";
import "package:country_utils/src/services/cache_service.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "../../dummies/dummy_localized_strings.dart";

void main() {
  group("RTMCountryPicker", () {
    group("UI", () {
      testWidgets("With default configuration", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RTMCountryPicker(),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountryPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(1));
        final widgetFlag = find.byType(RTMCountryFlag);
        expect(widgetFlag, findsNWidgets(1));
      });
      testWidgets("With default selection", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: RTMCountryPicker(
              initialSelection: "FR",
            ),
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountryPicker);
        expect(widgetWidget, findsNWidgets(1));

        final widgetButton = find.byType(TextButton);
        expect(widgetButton, findsNWidgets(1));
        final widgetFlag = find.byType(RTMCountryFlag);
        expect(widgetFlag, findsNWidgets(1));
        final widgetText = find.text("France");
        expect(widgetText, findsNWidgets(1));
      });
    });
  });
}
