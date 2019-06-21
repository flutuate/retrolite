import 'dart:io';

import 'package:retrolite/flutuate_api.dart' show Headers, Header;
import 'package:test/test.dart';

void main() {
  group('Class Header methods tests', () {
    test('Test return from .toString()', () {
      final header = Headers.Accepts('application/json', 'charset=utf-8');
      expect(header.toString(), 'accept: application/json;charset=utf-8');
    });

    test(
        'Create a header with with name, value and parameters null throws argument errot exception',
        () {
      expect(() => Headers.custom(null, value: null, parameters: null),
          throwsArgumentError);
    });

    test(
        'Create a header with with name and value null throws argument errot exception',
        () {
      expect(() => Headers.custom('custom', value: null, parameters: null),
          throwsArgumentError);
    });

    test('Test creation a header parameters null', () {
      final header =
          Headers.custom('custom', value: 'my value', parameters: null);
      expect(header.parameters, isEmpty);
      expect(header.toString(), 'custom: my value');
    });

    test('Test creation a header parameters empty', () {
      final header =
          Headers.custom('custom', value: 'my value', parameters: ['']);
      expect(header.parameters, isNotEmpty);
      expect(header.toString(), 'custom: my value;');
    });

    test('Header with value containing list with null element throws exception',
        () {
      expect(
          () => Headers.custom('custom', value: [null]), throwsArgumentError);
    });

    test('Accept header', () {
      final header = new Header(HttpHeaders.acceptHeader, ContentType.text);

      expect(header.toString(), 'accept: text/plain; charset=utf-8');
      expect(header.name, HttpHeaders.acceptHeader);
      expect(header.value, ContentType.text);
    });

    test('Create an accept header with multiples parameters', () {
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

      Header acceptHeader =
          new Header(HttpHeaders.acceptHeader, ContentType.text, parameters);

      final entry = acceptHeader.toMapEntry();

      expect(entry, isNotNull);
      expect(entry.key, HttpHeaders.acceptHeader);
      expect(
          entry.value,
          ContentType.text.toString() +
              ';João Smith,45,1.23,abc,123,4.56,true,v1=1,v2=0.2,v3=3,v4=true');
    });
  });
}
