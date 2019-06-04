import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/src/http/IApi.dart';

abstract class IRestClient {
  TApi register<TApi extends IApi>(TApi api);

  /// TODO add parameter 'timeout'
  Future<TReturn> get<TReturn>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters});

  /// TODO add parameter 'timeout'
  Future<TReturn> post<TReturn>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      dynamic body});
}
