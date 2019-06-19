import 'dart:convert';

class RegisterResult {
  final int id;
  final String token;

  RegisterResult.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        token = json['token'];

  static RegisterResult deserialize(String body) =>
      new RegisterResult.fromJson(json.decode(body));


}
