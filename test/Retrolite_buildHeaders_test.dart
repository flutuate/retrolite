import 'dart:io';

import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

Map<String, HeaderValue> buildHeaders() {
  Map<String, HeaderValue> headers = {};

  HeaderValue value = new HeaderValue("text/plain", {"q": "0.3"});
  headers[HttpHeaders.acceptHeader, values];
  headers.add(HttpHeaders.acceptHeader, "text/html");
  return headers;
}

void main() {
  group('Build methods of Retrolite tests', () {

    var retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost:8080');
      HttpClientRequest x;
      x.headers;
    });

    test('todo', () {
      Map<String, HeaderValue> headers = buildHeaders();
      Map<String, String> buildedHeaders = retrolite.buildHeaders(headers);
      expect(parameters, isEmpty);
    });

  });
}

