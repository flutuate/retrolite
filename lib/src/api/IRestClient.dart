import 'dart:io';

import 'package:http/http.dart' as http;

import 'Headers.dart';
import 'IApi.dart';
import 'Response.dart';
import 'types/core.dart';

/// TODO add parameter 'timeout' on the methods.
abstract class IRestClient {
  TApi register<TApi extends IApi>(TApi api);

  /// Make a GET request to a service at the [route].
  /// [deserializer] point to the method used to deserialize the response body
  /// to the type [TResult].
  Future<Response<TResult>> get<TResult>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      DeserializerFunction<TResult> deserializer});

  /// Make a POST request to a service at the [route].
  /// [deserializer] point to the method used to deserialize the response body
  /// to an instance of [TResult] type.
  Future<Response<TResult>> post<TResult>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      DeserializerFunction<TResult> deserializer,
      dynamic body});

  /// Make a PUT request to a service at the [route].
  /// [deserializer] point to the method used to deserialize the response body
  /// to an instance of [TResult] type.
  Future<Response<TResult>> put<TResult>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      DeserializerFunction<TResult> deserializer,
      dynamic body});

  /// Make a PATCH request to a service at the [route].
  /// [deserializer] point to the method used to deserialize the response body
  /// to an instance of [TResult] type.
  Future<Response<TResult>> patch<TResult>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      DeserializerFunction<TResult> deserializer,
      dynamic body});

  /// Make a HEAD request to a service at the [route].
  /// [deserializer] point to the method used to deserialize the response body
  /// to an instance of [TResult] type.
  Future<Response<TResult>> head<TResult>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      DeserializerFunction<TResult> deserializer});

  /// Make a DELETE request to a service at the [route].
  /// [deserializer] point to the method used to deserialize the response body
  /// to an instance of [TResult] type.
  Future<Response<TResult>> delete<TResult>(String route,
      {List<Header> headers,
      ContentType contentType,
      Map<String, dynamic> formDataParameters,
      Map<String, dynamic> queryParameters,
      DeserializerFunction<TResult> deserializer});
}

/// Returns an instance of the default http client.
http.BaseClient newDefaultHttpClient() => http.Client();
