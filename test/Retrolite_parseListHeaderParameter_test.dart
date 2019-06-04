import 'dart:convert';
import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main()
{
  group('Retrolite.parseListMapHeaderParameter tests', () {

    Retrolite retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost/');
    });

    test('Test passing a list with primitives parameters', () {
      List parameter = [
        'João Smith', 45, 1.23, true
      ];
      String parsedParameter = retrolite.parseListHeaderParameter(parameter);

      expect(parsedParameter, 'João Smith,45,1.23,true');
    });

    test('Test passing a list with primitive and list parameters', () {
      List parameter = [
        'João Smith', 45, 1.23, true,
        [
          'abc', 123, 4.56, true
        ]
      ];
      String parsedParameter = retrolite.parseListHeaderParameter(parameter);

      expect(parsedParameter, 'João Smith,45,1.23,true,abc,123,4.56,true');
    });

    test('Test passing a list with primitive, list and map parameters', () {
      List parameter = [
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
      String parsedParameter = retrolite.parseListHeaderParameter(parameter);

      expect(parsedParameter, 'João Smith,45,1.23,abc,123,4.56,true,v1=1,v2=0.2,v3=3,v4=true');
    });

  });
}

