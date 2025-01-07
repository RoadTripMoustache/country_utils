/// Exception thrown when a country is required in a service or widget and
/// nothing was found.
class CountryNotFoundException implements Exception {
  String cause;
  CountryNotFoundException(this.cause);
}
