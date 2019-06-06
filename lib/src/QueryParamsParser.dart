import 'dart:convert';

mixin QueryParamsParser
{
  /// Build and returns an url encoded string containing the parameters specified
  /// in [queryParameters].
  ///
  /// **[List] parameters** are converted to following encoded format:
  /// ```html
  /// name-parameter=[value0,value1,..,valueN]
  /// ```
  ///
  /// Using the example:
  /// ```dart
  ///   Map<String, dynamic> queryParameters = {
  ///      'values': ['+554733331234', 13579.02468, 54321]
  ///    };
  /// ```
  /// the result will be:
  /// ```html
  /// '?values=%5B%22%2B554733331234%22%2C13579.02468%2C54321%5D'
  /// ```
  ///
  /// **[Map] parameters** are converted to following encoded format:
  /// ```html
  /// name-parameter={{key0:value0},{key1:value1},..,{keyN:valueN}}
  /// ```
  ///
  /// Using the example:
  /// ```dart
  ///   Map<String, dynamic> queryParameters = {
  ///      'values': ['John Smith', {'age':45} ]
  ///   };
  /// ```
  /// the result will be:
  /// ```html
  /// '?values=%5B%22John+Smith%22%2C%7B%22age%22%3A45%7D%5D'
  /// ```
  String buildQueryParameters(Map<String, dynamic> queryParameters) {
    queryParameters ??= {};
    String formattedParameters = '';
    for( String name in queryParameters.keys ) {
      final value = queryParameters[name];
      final formattedValue = encodeQueryValue(value);
      final delimiter = formattedParameters.isEmpty ? '?' : '&';
      formattedParameters += '$delimiter${name.trim()}=$formattedValue';
    }
    return formattedParameters;
  }

  /// Encodes and returns an url query [value].
  ///
  /// For example, if [value] is ```null```, it'll be encoded to an empty string (```''```).
  /// If [value] is an empty [List], it'll be encoded to ```[]```.
  /// And when [value] is an empty [Map], it'll be encoded to ```{}```.
  /// Otherwise, the value returned from [value.toString] will be encoded.
  String encodeQueryValue(dynamic value) {
    String formattedValue;
    if( value == null ) {
      formattedValue = '';
    }
    else if( value is List ) {
      formattedValue = formatQueryValueAsList(value);
    }
    else if( value is Map ) {
      formattedValue = formatQueryValueAsMap(value);
    }
    else {
      formattedValue = value.toString();
    }
    return Uri.encodeQueryComponent(formattedValue);
  }

  /// Format [values] in a [List].
  ///
  /// For example, if the parameter [values] is ```null```, the method returns ```[]```.
  /// Elements ```null``` inside it, will be formatted to ```null```.
  /// If the parameter contains [Map] values, they will be formatted as described
  /// in [formatQueryValueAsMap].
  /// To primitives values, it will be used the value returned from method ```toString()```.
  /// [String] values will be formatted with quotes (```"value"```).
  /// Finally, if the parameter contains [List] values, they will be formatted as described above.
  String formatQueryValueAsList(List values) {
    if( values == null ) {
      return '';
    }
    String formattedValue = '[';
    for( var value in values ) {
      if(formattedValue.length > 1) {
        formattedValue += ',';
      }

      if( value == null ) {
        formattedValue += 'null';
      }
      else if( value is String ) {
        formattedValue += '\"$value\"';
      }
      else if(value is List) {
        formattedValue += formatQueryValueAsList(value);
      }
      else if(value is Map) {
        formattedValue += formatQueryValueAsMap(value);
      }
      else {
        formattedValue += value.toString();
      }
    }
    return formattedValue + ']';
  }

  /// Format [values] in a [Map].
  ///
  /// For example, if the parameter [values] is ```null```, the method returns ```{}```.
  /// Elements ```null``` inside it, will be formatted to ```null```.
  /// If the parameter contains [List] values, they will be formatted as described
  /// on [formatQueryValueAsList].
  /// To primitives values, it will be used the value returned from method ```toString()```.
  /// [String] values will be formatted with quotes (```"value"```).
  /// Finally, if the parameter contains [Map] values, they will be formatted as described above.
  String formatQueryValueAsMap(Map values) {
    if(values == null) {
      return '';
    }
    return json.encode(values);
  }
}