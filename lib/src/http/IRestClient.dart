import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/src/http/IApi.dart';
import 'package:retrolite/src/http/Response.dart';

abstract class IRestClient
{
  TApi register<TApi extends IApi>(TApi api);

  /// TODO add parameter 'timeout'
  Future<Response<TResult>> get<TResult>(
      String route,
      {
        List<Header> headers,
        ContentType contentType,
        Map<String, dynamic> formDataParameters,
        Map<String, dynamic> queryParameters,
        DeserializerFunction<TResult> deserializer
      } );

  /// TODO add parameter 'timeout'
  Future<Response<TResult>> post<TResult>(
      String route,
      {
        List<Header> headers,
        ContentType contentType,
        Map<String, dynamic> formDataParameters,
        Map<String, dynamic> queryParameters,
        DeserializerFunction<TResult> deserializer,
        dynamic body
      } );
}
