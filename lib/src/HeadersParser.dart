import 'dart:io';
import 'package:flutuate_api/flutuate_api.dart';

mixin HeadersParser {
  /// Parses a [Header] list to a [Map]<String,String> and returns it.
  ///
  /// The method throws an [ArgumentError] if any element of [headers] is ```null```.
  Map<String, String> parseHeaders(
      ContentType contentType, List<Header> headers) {
    Map<String, String> buildedHeaders = {};
    headers ??= [];
    for (Header header in headers) {
      if (header == null) {
        throw ArgumentError('List of headers can not have null elements');
      }
      MapEntry<String, String> entry = header.toMapEntry();
      buildedHeaders.addEntries([entry]);
    }
    if (contentType != null) {
      buildedHeaders[HttpHeaders.contentTypeHeader] = contentType.toString();
    }
    return buildedHeaders;
  }
}
