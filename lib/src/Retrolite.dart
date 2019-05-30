import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

import '../flutuate_http.dart';
import 'RetroliteParameters.dart';
import 'package:retrolite/src/http/core.dart';

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
  Future<TReturn> post<TReturn>(String route,
      {Map<String, HeaderValue> headers,
        ContentType contentType,
        Map<String, dynamic> formDataParameters,
        Map<String, dynamic> queryParameters,
        dynamic body}) async
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

  /*Map<String, String> buildHeaders() =>
      { "Content-Type": contentType.toString() };

  dynamic buildContent() {
    if( isValid(content) ) {
      if( isTypeJson(contentType) ) {
        return json.encode(content);
      }
      else if( isTypeText(contentType) ) {
        return content as String;
      }
    }
    return null;
  }*/

  bool isTypeJson(ContentType contentType)
    => contentType.subType == ContentType.json.subType;

  bool isTypeText(ContentType contentType)
    => contentType.subType == ContentType.text.subType;

  @override
  Future<TReturn> get<TReturn>(String route,
      {Map<String, HeaderValue> headers,
        ContentType contentType,
        Map<String, dynamic> formDataParameters,
        Map<String, dynamic> queryParameters}) async
  {
    /*http.Response response = await httpClient.get(
        buildUrl(route, queryParameters),
        headers: _buildHeaders(headers)
    );
    request.headers.contentType = contentType;
    HttpClientResponse response = await request.close();
    String content = await response.transform(utf8.decoder).join();
    TReturn.runtimeType is String;
    if (typeof<TReturn>() == String) {
      return Future<TReturn>.value(content as TReturn);
    }*/
    return null;
  }

  Uri buildUrl(String route, [Map<String, dynamic> queryParameters]) {
    String url = buildHost() + route;
    String queryParams = buildQueryParameters(queryParameters ?? {});
    return Uri.parse(url+queryParams);
  }

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
  String buildQueryParameters(Map<String, dynamic> queryParameters) {
    queryParameters ??= {};
    String formattedParameters = '';
    for( String name in queryParameters.keys ) {
      final value = queryParameters[name];
      final formattedValue = formatQueryValue(value);
      final delimiter = formattedParameters.isEmpty ? '?' : '&';
      formattedParameters += '$delimiter${name.trim()}=$formattedValue';
    }
    return formattedParameters;
  }

  String formatQueryValue(dynamic value) {
    if( value == null ) {
      return '';
    }
    else if( value is List ) {
      return formatQueryAsList(value);
    }
    else if( value is Map ) {
      return formatQueryAsMap(value);
    }
    return Uri.encodeQueryComponent(value.toString());
  }

  String formatQueryAsList(List values) {
    String formattedParameter = '[';
    for( var value in values ) {
      if(formattedParameter.length > 1) {
        formattedParameter += ',';
      }
      if( value is String ) {
        formattedParameter += '\"$value\"';
      }
      else if(value is Map) {
        formattedParameter += formatQueryAsMap(value);
      }
      else {
        formattedParameter += value.toString();
      }
    }
    return Uri.encodeQueryComponent(formattedParameter + ']');
  }

  String formatQueryAsMap(Map values) {
    return Uri.encodeQueryComponent(json.encode(values));
  }

  String serializeKey(dynamic value) {
    if( value is String ) {
      return '\"$value\"';
    }
    return '${value.toString()}';
  }

  TApi create<TApi extends IApi>(TApi api) {
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
  }

}