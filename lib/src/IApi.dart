import 'dart:io';

abstract class IApi
{
  Future<T> get<T>();

  Future<T> post<T>();

  ContentType contentType;

  IApi body(dynamic body) => content(body);

  dynamic content;

  String route;

  Map<String, dynamic> _parameters = {};

  set parameters(Map<String,dynamic> parameters) =>
      _parameters = parameters ?? {};

  Map<String, dynamic> get parameters => _parameters;
}
