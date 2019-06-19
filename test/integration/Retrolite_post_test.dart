import 'dart:core';

import 'package:retrolite/flutuate_api.dart' show Response;
import 'package:retrolite/retrolite.dart' hide isNotNull;
import 'package:test/test.dart';

import '../../example/reqres/RegisterContent.dart';
import '../../example/reqres/RegisterResult.dart';
import '../../example/reqres/ReqResApi.dart';
import '../../example/retrolite_example.dart';

void main() {
  group('Retrolite.post integration tests', () {
    Retrolite retrolite;
    ReqResApi api;

    setUpAll(() {
      retrolite = Retrolite('https://reqres.in/',
          httpClientCreator: newUnsafeHttpClient);

      api = retrolite.register<ReqResApi>(new ReqResApi());
    });

    test('Call a request with post in REQ|RES', () async {
      RegisterContent content =
          new RegisterContent('eve.holt@reqres.in', 'pistol');
      Response<RegisterResult> response = await api.register(content);
      expect(response.value, isNotNull);
      expect(response.value.id, isNotNull);
      expect(response.value.token, isNotNull);
    });
  });
}
