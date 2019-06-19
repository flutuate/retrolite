import 'dart:core';
import 'dart:io';

import 'package:flutuate_api/flutuate_api.dart';

import 'RegisterContent.dart';
import 'RegisterResult.dart';

class ReqResApi extends IApi {

  /// Call an API from ```https://reqres.in```
  Future<Response<RegisterResult>> register(RegisterContent content) =>
      client.post<RegisterResult>('api/register',
          deserializer: RegisterResult.deserialize,
          contentType: ContentType.json,
          body: content
      );
}
