import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.formatQueryValueAsMap tests', () {

    Retrolite retrolite;

    setUp(() {
      retrolite = Retrolite('http://localhost:8080');
    });

    test('Passing map empty', () {
      var formattedValue = retrolite.formatQueryValueAsMap({});
      expect(formattedValue, '{}');
    });

    test('Passing null', () {
      var formattedValue = retrolite.formatQueryValueAsMap(null);
      expect(formattedValue, isEmpty);
    });

    test('Map containing one argument string', () {
      var queryParameters = { 'name': 'Smith' };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"name":"Smith"}');
    });

    test('Map containing one string with latin characters', () {
      var queryParameters = { 'name': 'João Smith' };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"name":"João Smith"}');
    });

    test('Map containing some primitive arguments', () {
      var queryParameters = {'name':'Smith', 'age': 45, 'height': 1.80 };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, 'null');
    });

    test('Map containing some arguments with special chars', () {
      var queryParameters = {'name':'João Smith', 'age':45, 'height': 1.80, 'specialChars': '%\\/@#:\'\"' };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, 'null');
    });

    test('Map containing a null argument', () {
      var queryParameters = {'nullValue': null};
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"nullValue":null}');
    });

    test('Map containing a empty list', () {
      var queryParameters = { 'emptyList': [] };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"emptyList":[]}');
    });

    test('Map containing a empty map', () {
      var queryParameters = { 'emptyMap': {} };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"emptyMap":{}}');
    });

    test('Map containing an empty map and an empty list', () {
      var queryParameters = { 'emptyMap': {}, 'emptyList': [] };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"emptyMap":{},"emptyList":[]}');
    });

    test('Map containing an empty map and an list containing a primitive argument', () {
      var queryParameters = { 'emptyMap' : {}, 'list': ['João'] };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"emptyMap":{},"list":["João"]}');
    });

    test('Map containing a list argument', () {
      var queryParameters = { 'list': ['João', ['Smith', 'da Silva'] ] };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue,  '{"list":["João",["Smith","da Silva"]]}');
    });

    test('Map containing a list with a map', () {
      var queryParameters = {"map":{'name':'João Smith'}};
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '{"map":{"name":"João Smith"}}');
    });

    test('Map with primitives and map arguments', () {
      var queryParameters = {
        'City': {
          'name': 'Londrina',
          'latitude': -23.31028,
          'longitude': -51.16278
        }
      };
      var formattedValue = retrolite.formatQueryValueAsMap(queryParameters);
      expect(formattedValue, '["City",{"name":"Londrina","latitude":-23.31028,"longitude":-51.16278}]');
    });

  });
}
