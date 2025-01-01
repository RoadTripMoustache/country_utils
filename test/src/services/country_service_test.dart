import "package:country_utils/country_utils.dart";
import "package:country_utils/src/services/cache_service.dart";
import "package:flutter_test/flutter_test.dart";

import "../../dummies/dummy_localized_strings.dart";

void main() {
  group("CountryService", () {
    group("getCountryByCode", () {
      for (final testCase in [
        "FR",
        "fr",
        "Fr",
        "fR",
        "FRA",
        "fra",
        "Fra",
        "fRa"
      ]) {
        test(testCase, () {
          CacheService.updateLocalizedStrings(dummyLocalizedStrings);

          final Country? result = CountryService.getCountryByCode(testCase);
          expect(result, isNotNull);
          expect(result?.name, "France");
          expect(result?.isoCodeAlpha2, "FR");
          expect(result?.isoCodeAlpha3, "FRA");
          expect(result?.dialCode, "+33");
        });
      }

      test("Not existing code", () {
        CacheService.updateLocalizedStrings(dummyLocalizedStrings);

        final Country? result = CountryService.getCountryByCode("toto");
        expect(result, isNull);
      });
    });

    test("getCountries", () {
      CacheService.updateLocalizedStrings(dummyLocalizedStrings);

      final List<Country> result = CountryService.getCountries();
      expect(result, isNotNull);
      expect(result.length, 247);
    });
  });
}
