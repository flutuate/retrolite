import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/src/http/IApi.dart';
import 'package:retrolite/src/http/Response.dart';

typedef T ParserFunction<T>(Map<String,dynamic> json);

abstract class IRestClient
{
  TApi register<TApi extends IApi>(TApi api);

  /// TODO add parameter 'timeout'
  Future<Response<TReturn>> get<TReturn extends IDeserializable>(
      String route,
      {
        List<Header> headers,
        ContentType contentType,
        Map<String, dynamic> formDataParameters,
        Map<String, dynamic> queryParameters,
        ParserFunction<TReturn> parser
      } );

  Future<TResponse> get2<TResponse extends Response>(
      String route,
      {
        List<Header> headers,
        ContentType contentType,
        Map<String, dynamic> formDataParameters,
        Map<String, dynamic> queryParameters
      } );

  /// TODO add parameter 'timeout'
  Future<Response<TReturn>> post<TReturn extends IDeserializable>(
      String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      dynamic body});
}
