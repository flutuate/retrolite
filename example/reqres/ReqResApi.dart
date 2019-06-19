import 'dart:core';
import 'dart:io';

import 'package:flutuate_api/flutuate_api.dart';

import 'RegisterContent.dart';
import 'RegisterResult.dart';
import 'Users.dart';

/// [REQ|RES](https://reqres.in) API provider.
class ReqResApi extends IApi {
  /// Get the users list.
  Future<Response<ListUsers>> listUsers(int page) => client.get<ListUsers>(
        'api/users?page=$page',
        contentType: ContentType.json,
        deserializer: ListUsers.deserialize,
      );

  /// Request the users list with delay.
  Future<Response<ListUsers>> listUsersWithDelay(int delay) =>
      client.get<ListUsers>(
        'api/users',
        queryParameters: {
          'delay': delay
        },
        contentType: ContentType.json,
        deserializer: ListUsers.deserialize,
      );

  /// Request the register service with success.
  Future<Response<RegisterResult>> register(RegisterContent content) =>
      client.post<RegisterResult>('api/register',
          deserializer: RegisterResult.deserialize,
          contentType: ContentType.json,
          body: content);
}
