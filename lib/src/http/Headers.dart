import 'dart:io';

class Headers
{
  static Header Accepts(String value, [Object parameters]) {
    return new Header(HttpHeaders.acceptHeader, value, parameters);
  }

  //static Header custom(String name, {String value, Map<String, String> parameters})
  static Header custom(String name, {String value, List<Object> parameters})
  {
    return new Header(name, value, parameters);
  }
}

class Header
{
  final String name;
  final Object value;
  final List parameters = [];

  Header(this.name, this.value, [Object parameter]) {
    if( !isValidValue(value) ) {
      throw ArgumentError('Value must be String or ContentType');
    }
    if(parameter != null) {
      add(parameter);
    }
  }

  void add(Object parameter) {
    parameters.add(parameter);
  }

  static bool isValidValue(Object value) => (value is String) || (value is ContentType);
}