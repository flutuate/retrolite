import 'dart:io';
import 'package:flutuate_api/flutuate_api.dart';

@deprecated
mixin HeadersParser
{
  /// Parses a [Header] list to a [Map]<String,String> and returns it.
  ///
  /// The method throws an [ArgumentError] if any element of [headers] is ```null```.
  Map<String,String> parseHeaders(ContentType contentType, List<Header> headers) {
    Map<String,String> buildedHeaders = {};
    headers ??= [];
    for( Header header in headers ) {
      //MapEntry<String,String> entry = parseMapEntryHeader(header);
      MapEntry<String,String> entry = header.toMapEntry(header);
      buildedHeaders.addEntries( [ entry ] );
    }
    if( contentType != null ) {
      buildedHeaders[HttpHeaders.contentTypeHeader] = contentType.toString();
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

}

