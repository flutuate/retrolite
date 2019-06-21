import 'dart:core';
import 'dart:io';

import 'package:retrolite/flutuate_api.dart';
import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

import '../../example/retrolite_example.dart';

void main() {
  group('Retrolite.head integration tests', () {
    Retrolite retrolite;
    LocalApi api;

    setUpAll(() async {
      createServer();
      retrolite = Retrolite('http://localhost:8080/',
          httpClientCreator: newUnsafeHttpClient);

      api = retrolite.register<LocalApi>(new LocalApi());
    });

    test('Test HEAD request at local api', () async {
      Response<void> response = await api.head();
      expect(response.statusCode, HttpStatus.ok);
    });
  });
}

void createServer() {
  HttpServer.bind("localhost", 8080).then((HttpServer server) {
    print('Server started at ${server.toString()}');
    server.listen((HttpRequest request) {
      request.response.statusCode = HttpStatus.ok;
      request.response.close();
    });
  });
}

class LocalApi extends IApi {
  /// Get the users list.
  Future<Response<void>> head() => client.head<void>(
        '/',
        contentType: ContentType.json,
      );
}
