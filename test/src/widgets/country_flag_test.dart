import "package:country_utils/src/services/cache_service.dart";
import "package:country_utils/src/widgets/country_flag.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "../../dummies/dummy_localized_strings.dart";

void main() {
  group("RTMCountryFlag", () {
    group("UI", () {
      testWidgets("With ISO Code Alpha 2", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          RTMCountryFlag(
            countryCode: "JP",
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountryFlag);
        expect(widgetWidget, findsNWidgets(1));

        final widgetImage = find.byType(Image);
        expect(widgetImage, findsNWidgets(1));
        final image = tester.firstWidget<Image>(widgetImage);
        expect((image.image as AssetImage).assetName, "assets/flags/jp.png");
        expect(image.fit, BoxFit.none);
      });

      testWidgets("With ISO Code Alpha 3", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          RTMCountryFlag(
            countryCode: "Jpn",
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountryFlag);
        expect(widgetWidget, findsNWidgets(1));

        final widgetImage = find.byType(Image);
        expect(widgetImage, findsNWidgets(1));
        final image = tester.firstWidget<Image>(widgetImage);
        expect((image.image as AssetImage).assetName, "assets/flags/jp.png");
        expect(image.fit, BoxFit.none);
      });

      testWidgets("With custom parameters", (WidgetTester tester) async {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);
        await tester.pumpWidget(
          RTMCountryFlag(
            countryCode: "Jpn",
            width: 22,
            height: 33,
            fit: BoxFit.fill,
          ),
        );
        await tester.pumpAndSettle();

        final widgetWidget = find.byType(RTMCountryFlag);
        expect(widgetWidget, findsNWidgets(1));

        final widgetImage = find.byType(Image);
        expect(widgetImage, findsNWidgets(1));
        final image = tester.firstWidget<Image>(widgetImage);
        expect((image.image as AssetImage).assetName, "assets/flags/jp.png");
        expect(image.fit, BoxFit.fill);
        expect(image.width, 22);
        expect(image.height, 33);
      });
    });
  });
}
