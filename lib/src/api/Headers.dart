import 'dart:io';

import 'package:retrolite/flutuate_api.dart';

/// Convenience class containing commons HTTP headers and methods to create
/// customized headers.
class Headers {
  /// Returns a [Header] representing a HTTP ```Accept``` header.
  static Header Accepts(String value, [Object parameters]) {
    return Header(HttpHeaders.acceptHeader, value, parameters);
  }

  /// Creates a customized HTTP header.
  static Header custom(String name, {Object value, List<Object> parameters}) {
    return Header(name, value, parameters);
  }
}

/// Represents a HTTP header.
class Header {
  final String name;
  final Object value;
  final List parameters = [];

  /// Creates a new instance of [Header].
  /// [name] and [value] must not be null or an [ArgumentError] will be throwed.
  Header(this.name, this.value, [Object parameter]) {
    if (isNullOrEmpty(name)) {
      throw ArgumentError('Name must not be null or empty');
    } else if (!_isValidValue(value)) {
      throw ArgumentError('Value must be String or ContentType');
    }
    if (parameter != null) {
      add(parameter);
    }
  }

  /// Add a [parameter] in this header.
  void add(Object parameter) {
    parameters.add(parameter);
  }

  static bool _isValidValue(Object value) =>
      (value is String) || (value is ContentType);

  /// Parses this [Header] to a [MapEntry]<String,String>.
  ///
  /// Elements in [Header.parameters] must not be null or an [ArgumentError]
  /// will be throwed.
  /// Primitives elements will be parsed with ```toString()```.
  /// [Map] elements, will be parsed with method [parseMapHeaderParameter],
  /// and [List] elements with [parseListHeaderParameter].
  MapEntry<String, String> toMapEntry() {
    String theValue = '${value.toString()}';
    if (parameters.isNotEmpty) {
      theValue += ';';
    }
    int parametersCount = 0;
    for (var parameter in parameters) {
      if (++parametersCount > 1) {
        theValue += ',';
      }
      if (parameter is Map) {
        theValue += parseMapHeaderParameter(parameter);
      } else if (parameter is List) {
        theValue += parseListHeaderParameter(parameter);
      } else {
        theValue += parameter.toString();
      }
    }
    return MapEntry<String, String>(name, theValue);
  }

  /// Parses a [List] header ([Header]) parameter to [String].
  ///
  /// [Map] elements will be parsed with [parseMapHeaderParameter] and
  /// [List] elements with this method.
  String parseListHeaderParameter(List listParameter) {
    listParameter ??= [];
    String parsedParameter = '';
    for (var element in listParameter) {
      if (parsedParameter.isNotEmpty) {
        parsedParameter += ',';
      }
      if (element is Map) {
        parsedParameter += parseMapHeaderParameter(element);
      } else if (element is List) {
        parsedParameter += parseListHeaderParameter(element);
      } else {
        parsedParameter += element.toString();
      }
    }
    return parsedParameter;
  }

  /// Parses a [Map] header ([Header]) parameter to [String].
  ///
  /// [Map] elements will be parsed with this method and
  /// [List] elements with [parseListHeaderParameter].
  String parseMapHeaderParameter(Map mapParameter) {
    String parsedParameter = '';
    for (var entry in mapParameter.entries) {
      if (parsedParameter.isNotEmpty) {
        parsedParameter += ',';
      }
      parsedParameter += '${entry.key}=';
      if (entry.value is Map) {
        parsedParameter += parseMapHeaderParameter(entry.value);
      } else if (entry.value is List) {
        parsedParameter += parseListHeaderParameter(entry.value);
      } else {
        parsedParameter += entry.value.toString();
      }
    }
    return parsedParameter;
  }

  @override
  String toString() {
    MapEntry<String, String> entry = toMapEntry();
    return '$name: ${entry.value}';
  }
}
