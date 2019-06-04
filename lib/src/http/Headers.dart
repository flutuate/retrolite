import 'dart:io';

/// Convenience class containing commons HTTP headers and methods to create
/// an customized headers.
class Headers
{
  /// Returns a [Header] representing a HTTP ```Accept``` header.
  static Header Accepts(String value, [Object parameters]) {
    return new Header(HttpHeaders.acceptHeader, value, parameters);
  }

  /// Creates a customized HTTP header.
  static Header custom(String name, {String value, List<Object> parameters}) {
    return new Header(name, value, parameters);
  }
}

/// Represents a HTTP header.
class Header
{
  final String name;
  final Object value;
  final List parameters = [];

  Header(this.name, this.value, [Object parameter]) {
    if( !_isValidValue(value) ) {
      throw ArgumentError('Value must be String or ContentType');
    }
    if(parameter != null) {
      add(parameter);
    }
  }

  /// Add a [parameter] in this header.
  void add(Object parameter) {
    parameters.add(parameter);
  }

  static bool _isValidValue(Object value) => (value is String) || (value is ContentType);
}