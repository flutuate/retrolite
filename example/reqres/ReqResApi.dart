import 'dart:core';
import 'dart:io';

import 'package:flutuate_api/flutuate_api.dart';

import 'RegisterContent.dart';
import 'RegisterResult.dart';
import 'Users.dart';

class ReqResApi extends IApi {
  /// Call the *list users* service from ```https://reqres.in```
  Future<Response<ListUsers>> listUsers(int page) => client.get<ListUsers>(
        'api/users?page=$page',

        /// Or use:
        /// queryParameters: {
        ///  'page': 2
        ///},
        contentType: ContentType.json,
        deserializer: ListUsers.deserialize,
      );

  /// Call the *register - successful* service from ```https://reqres.in```
  Future<Response<RegisterResult>> register(RegisterContent content) =>
      client.post<RegisterResult>('api/register',
          deserializer: RegisterResult.deserialize,
          contentType: ContentType.json,
          body: content);
}
