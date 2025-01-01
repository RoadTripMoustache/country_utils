import "package:country_utils/src/exceptions/localization_not_loaded_exception.dart";
import "package:country_utils/src/services/cache_service.dart";
import "package:flutter_test/flutter_test.dart";

import "../../dummies/dummy_localized_strings.dart";

void main() {
  group("CacheService", () {
    test("Without value set", () {
      try {
        CacheService.localizedStrings;
        fail("No exception where thrown");
      } on LocalizationNotLoadedException {
        expect(true, isTrue);
      }
    });
    test("updateLocalizedStrings then check values", () {
      CacheService.updateLocalizedStrings(dummyLocalizedStrings);

      expect(CacheService.localizedStrings?.length, 250);
      expect(CacheService.countries.length, 247);
    });
  });
}
