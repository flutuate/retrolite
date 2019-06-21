import 'dart:io';

import 'package:retrolite/flutuate_api.dart';
import 'package:test/test.dart';

void main() {
  group('Header.toMapEntry tests', () {
    test('Passing a header without parametes', () {
      Header header = new Header(HttpHeaders.acceptHeader, 'text/plain');

      MapEntry<String, String> entry = header.toMapEntry();

      expect(entry.key, HttpHeaders.acceptHeader);
      expect(entry.value, 'text/plain');
    });

    test('Passing a header with ContentType', () {
      Header header = new Header(HttpHeaders.acceptHeader, ContentType.text);

      MapEntry<String, String> entry = header.toMapEntry();

      expect(entry.key, HttpHeaders.acceptHeader);
      expect(entry.value, ContentType.text.toString());
    });

    test('Passing a header with ContentType and parameters', () {
      List parameters = [
        'João Smith',
        45,
        1.23,
        ['abc', 123, 4.56, true],
        {
          'v1': 1,
          'v2': 0.2,
          'v3': '3',
          'v4': true,
        }
      ];

      Header header =
          new Header(HttpHeaders.acceptHeader, ContentType.text, parameters);

      MapEntry<String, String> entry = header.toMapEntry();

      expect(entry.key, HttpHeaders.acceptHeader);
      expect(
          entry.value,
          ContentType.text.toString() +
              ';João Smith,45,1.23,abc,123,4.56,true,v1=1,v2=0.2,v3=3,v4=true');
    });
  });
}
