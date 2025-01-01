/// Exception thrown when [CountryLocalization] is not correctly loaded.
///
/// If [CountryLocalizations] is not loaded, some services won't be able to
/// work correctly.
class LocalizationNotLoadedException implements Exception {
  String cause;
  LocalizationNotLoadedException(this.cause);
}
