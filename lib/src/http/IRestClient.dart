import 'dart:io';

import 'package:retrolite/src/http/IApi.dart';

abstract class IRestClient {
  TApi register<TApi extends IApi>(TApi api);

  Future<TReturn> get<TReturn>(String route,
      {Map<String, HeaderValue> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters});

  Future<TReturn> post<TReturn>(String route,
      {Map<String, HeaderValue> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      dynamic body});
}
