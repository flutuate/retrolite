import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:retrolite/retrolite.dart';
import 'package:retrolite/src/http/core.dart';

import '../flutuate_http.dart';

import 'HeadersParser.dart';
import 'QueryParamsParser.dart';
import 'ResponseBodyDeserializer.dart';
import 'http/Response.dart';

class Retrolite
  with HeadersParser, QueryParamsParser, ResponseBodyDeserializer
    implements IRestClient
{
  Map<Type, IApi> _apis = {};

  final String baseUrl;

  final http.BaseClient httpClient;

  Retrolite(String baseUrl, {http.BaseClient httpClient})
  : httpClient = httpClient ?? newDefaultHttpClient()
  , baseUrl = baseUrl.trim()
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
          parseUrl(route, queryParameters),
          headers: parseHeaders(headers)
      );

      Response<TReturn> response = parseResponseBody<TReturn>(httpResponse, deserializer: deserializer);

      return Future<Response<TReturn>>.value(response);
    }
    finally {
      httpClient.close();
    }
  }

  /// Parses a complete [Uri] using [baseUrl]+[route]+[queryParameters], already encoded.
  Uri parseUrl(String route, [Map<String, dynamic> queryParameters]) {
    String url = parseHost() + route;
    String queryParams = buildQueryParameters(queryParameters ?? {});
    return Uri.parse(url+queryParams);
  }

  /// Returns the [baseUrl] with a slash (```/```) at the its end if it does not contains.
  String parseHost() => baseUrl.endsWith('/') ? baseUrl : baseUrl + '/';

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

//~~~~~~~~~~~~~~~~~~~~~~ used?

  bool isTypeJson(ContentType contentType)
    => contentType.subType == ContentType.json.subType;

  bool isTypeText(ContentType contentType)
    => contentType.subType == ContentType.text.subType;
}

