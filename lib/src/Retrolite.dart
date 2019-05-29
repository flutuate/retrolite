import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:retrolite/src/IApi.dart';
import 'package:retrolite/src/IRestClient.dart';

import 'Query.dart';
import 'RetroliteParameters.dart';
import 'core.dart';

class Retrolite extends RetroliteParameters
{
  Map<Type, IApi> _apis = {};

  Retrolite({String baseUrl, http.BaseClient httpClient})
    : super(baseUrl, httpClient)
  {
    /*Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });*/
  }

  @override
  Future<T> post<T>() async {
    Uri uri = buildUri();
    IOClient ioClient = new IOClient(client);

    http.Client client = newLoggingClient(ioClient);

    http.Response response = await client.post(
        uri,
        headers: _buildHeaders(),
        body: _buildContent()
    );

    // TODO falta tratar status/retornos com erros
    String body = await response.body;
    print(body);
    return null;
  }

  Map<String, String> _buildHeaders() =>
      { "Content-Type": contentType.toString() };

  dynamic _buildContent() {
    if( isValid(content) ) {
      if( isTypeJson(contentType) ) {
        return json.encode(content);
      }
      else if( isTypeText(contentType) ) {
        return content as String;
      }
    }
    return null;
  }

  bool isTypeJson(ContentType contentType)
    => contentType.subType == ContentType.json.subType;

  bool isTypeText(ContentType contentType)
    => contentType.subType == ContentType.text.subType;

  @override
  Future<T> get<T>() async {
    Uri uri = buildUri();
    HttpClientRequest request = await _httpClient.getUrl(uri);
    request.headers.contentType = contentType;
    HttpClientResponse response = await request.close();
    String content = await response.transform(utf8.decoder).join();
    T.runtimeType is String;
    if( typeof<T>() == String ) {
      return Future<T>.value(content as T);
    }
    return null;
  }

  Uri buildUri() {
    String uri = _params.baseUrl + route;
    String queryParams = '';
    for( var name in parameters.keys ) {
      var param = parameters[name];
      if( param is Query ) {
        if( queryParams.isEmpty ) {
          queryParams = '?';
        }
        else {
          queryParams += '&';
        }
        queryParams += '$name=${param.value}';
      }
    }
    return Uri.parse(Uri.encodeFull(uri+queryParams));
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