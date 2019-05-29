import 'dart:io';

import 'IApi.dart';

abstract class IRestClient
{
  TApi register<TApi extends IApi>(TApi api);

  String route;

  ContentType contentType;

  Map<String, dynamic> _parameters = {};

  set parameters(Map<String,dynamic> parameters)
  => _parameters = parameters ?? {};

  Map<String, dynamic> get parameters
  => _parameters;

  IApi body(dynamic body)
    => content(body);

  dynamic content;

  Future<TReturn> get<TReturn>();

  Future<TReturn> post<TReturn>();

}

