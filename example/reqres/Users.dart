import 'dart:convert';

import 'Pagination.dart';
import 'User.dart';

class ListUsers extends Pagination {
  final List<User> users;

  ListUsers.fromJson(Map<String, dynamic> json)
      : users = usersFromJson(json['data']),
        super.fromJson(json);

  static ListUsers deserialize(String body) =>
      new ListUsers.fromJson(json.decode(body));

  static List<User> usersFromJson(List jsonUsers) {
    List<User> users = [];
    for (var jsonUser in jsonUsers) {
      users.add(User.fromJson(jsonUser));
    }
    return users;
  }
}
