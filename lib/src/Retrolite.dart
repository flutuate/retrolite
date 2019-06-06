import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../flutuate_http.dart';
import 'RetroliteParameters.dart';
import 'package:retrolite/src/http/core.dart';

import 'http/Response.dart';

class Retrolite extends RetroliteParameters
{
  Map<Type, IApi> _apis = {};

  Retrolite(String baseUrl, {http.BaseClient httpClient})
    : super(baseUrl.trim(), httpClient ?? newDefaultHttpClient())
  {
    /*Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });*/
  }

  @override
  Future<Response<TReturn>> post<TReturn>(
      String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      dynamic body})
  async
  {
    /*Uri uri = buildUri();
    IOClient ioClient = new IOClient(client);

    http.Client client = newLoggingClient(ioClient);

    http.Response response = await client.post(
        uri,
        headers: _buildHeaders(),
        body: _buildContent()
    );

    // TODO falta tratar status/retornos com erros
    String body = await response.body;
    print(body);*/
    return null;
  }

  bool isTypeJson(ContentType contentType)
    => contentType.subType == ContentType.json.subType;

  bool isTypeText(ContentType contentType)
    => contentType.subType == ContentType.text.subType;

  @override
  Future<Response<TReturn>> get<TReturn>(String route,
      {List<Header> headers,
        ContentType contentType,
        Map<String, dynamic> queryParameters,
        Map<String, dynamic> formDataParameters,
        DeserializerFunction<TReturn> deserializer} ) async
  {
    try {
      http.Response httpResponse = await httpClient.get(
          buildUrl(route, queryParameters),
          headers: parseHeaders(headers)
      );

      Response<TReturn> response = parseResponseBody<TReturn>(httpResponse, deserializer: deserializer);

      return Future<Response<TReturn>>.value(response);
    }
    finally {
      httpClient.close();
    }
  }

  Response parseResponseBody<TReturn>(http.Response httpResponse, {DeserializerFunction<TReturn> deserializer}) {
    String nameType = TReturn.toString().split(RegExp(r'\b')).first;
    String body = httpResponse.body.trim();
    if( nameType == 'int') {
      return new Response<int>(httpResponse, int.parse(body));
    }
    else if( nameType == 'bool' ) {
      return new Response<bool>(httpResponse, body.toLowerCase() == 'true');
    }
    else if( nameType == 'double' ) {
      return new Response<double>(httpResponse, double.parse(body));
    }
    else if( nameType == 'String') {
      return new Response<String>(httpResponse, body);
    }
    return new Response<TReturn>(httpResponse, deserializer(body));
  }

  /// Parses a complete [Uri] using [baseUrl]+[route]+[queryParameters], already encoded.
  Uri buildUrl(String route, [Map<String, dynamic> queryParameters]) {
    String url = buildHost() + route;
    String queryParams = buildQueryParameters(queryParameters ?? {});
    return Uri.parse(url+queryParams);
  }

  /// Returns the [baseUrl] with a slash (```/```) at the its end if it does not contains.
  String buildHost() => baseUrl.endsWith('/') ? baseUrl : baseUrl + '/';

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

  /// Parses a [Header] list to a [Map]<String,String> and returns it.
  ///
  /// The method throws an [ArgumentError] if any element of [headers] is ```null```.
  Map<String,String> parseHeaders(List<Header> headers) {
    Map<String,String> buildedHeaders = {};
    headers ??= [];
    for( Header header in headers ) {
      MapEntry<String,String> entry = parseMapEntryHeader(header);
      buildedHeaders.addEntries( [ entry ] );
    }
    return buildedHeaders;
  }

  /// Parses a [Header] to a [MapEntry]<String,String>.
  ///
  /// Elements in [Header.parameters] must not be null or an [ArgumentError]
  /// will be throwed.
  /// Primitives elements will be parsed with ```toString()```.
  /// [Map] elements, will be parsed with method [parseMapHeaderParameter],
  /// and [List] elements with [parseListHeaderParameter].
  MapEntry<String, String> parseMapEntryHeader(Header header) {
    if( header == null ) {
      throw ArgumentError('Header parameter cannot be null');
    }
    String value = '${header.value.toString()}';
    if( header.parameters.isNotEmpty ) {
      value += ';';
    }
    int parametersCount = 0;
    for( var parameter in header.parameters ) {
      if( ++parametersCount > 1 ) {
        value += ',';
      }
      if(parameter is Map) {
        value += parseMapHeaderParameter(parameter);
      }
      else if(parameter is List) {
        value += parseListHeaderParameter(parameter);
      }
      else  {
        value += parameter.toString();
      }
    }
    return new MapEntry<String,String>(header.name, value);
  }

  /// Parses a [List] header ([Header]) parameter to [String].
  ///
  /// [Map] elements will be parsed with [parseMapHeaderParameter] and
  /// [List] elements with this method.
  String parseListHeaderParameter(List listParameter) {
    listParameter ??= [];
    String parsedParameter = '';
    for( var element in listParameter ) {
      if( parsedParameter.isNotEmpty ) {
        parsedParameter += ',';
      }
      if( element is Map ) {
        parsedParameter += parseMapHeaderParameter(element);
      }
      else if( element is List ) {
        parsedParameter += parseListHeaderParameter(element);
      }
      else {
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
    for( var entry in mapParameter.entries ) {
      if( parsedParameter.isNotEmpty ) {
        parsedParameter += ',';
      }
      parsedParameter += '${entry.key}=';
      if( entry.value is Map ) {
        parsedParameter += parseMapHeaderParameter(entry.value);
      }
      else if( entry.value is List ) {
        parsedParameter += parseListHeaderParameter(entry.value);
      }
      else {
        parsedParameter += entry.value.toString();
      }
    }
    return parsedParameter;
  }

  /*
* To build an [:accepts:] header with the value
*
*     text/plain; q=0.3, text/html
*
* use code like this:
*
*     HttpClientRequest request = ...;
*     var v = new HeaderValue("text/plain", {"q": "0.3"});
*     request.headers.add(HttpHeaders.acceptHeader, v);
*     request.headers.add(HttpHeaders.acceptHeader, "text/html");
* */


//  String serializeKey(dynamic value) {
//    if( value is String ) {
//      return '\"$value\"';
//    }
//    return '${value.toString()}';
//  }

  TApi create<TApi extends IApi>(TApi api) {
    //TODO
    return api;
  }

  @override
  TApi register<TApi extends IApi>(TApi api) {
    api = _prepareApi(api);
    _apis[api.runtimeType] = api;
    return api;
  }

  IApi _prepareApi(IApi api) {
    api.client = this;
    return api;
  }


}