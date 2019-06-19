import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.formatQueryValueAsList tests', () {
    Retrolite retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost:8080');
    });

    test('Passing parameter empty', () {
      var formattedValue = retrolite.formatQueryValueAsList([]);
      expect(formattedValue, '[]');
    });

    test('Passing parameter null', () {
      var formattedValue = retrolite.formatQueryValueAsList(null);
      expect(formattedValue, isEmpty);
    });

    test('Passing list with one argument string', () {
      var queryParameters = ['Smith'];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '["Smith"]');
    });

    test('Passing list with one argument string with latin characters', () {
      var queryParameters = ['João Smith'];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '["João Smith"]');
    });

    test('Passing list with some primitive arguments', () {
      var queryParameters = ['Smith', 1234, 13579.02468];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '["Smith",1234,13579.02468]');
    });

    test('List with some arguments with special chars', () {
      var queryParameters = ['Smith', 1234, 13579.02468, ',', '%\\/@#:\'\"'];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '["Smith",1234,13579.02468,",","%\\/@#:\'""]');
    });

    test('Passing list with a null argument', () {
      var queryParameters = [null];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '[null]');
    });

    test('Passing list with a empty map argument', () {
      var queryParameters = [{}];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '[{}]');
    });

    test('Passing list with an empty map and an empty list arguments', () {
      var queryParameters = [{}, []];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '[{},[]]');
    });

    test(
        'Passing list with an empty map and an empty list containing a primitive argument',
        () {
      var queryParameters = [
        {},
        ['João']
      ];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '[{},["João"]]');
    });

    test('Passing list with a list argument', () {
      var queryParameters = [
        'João',
        ['Smith', 'da Silva']
      ];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '["João",["Smith","da Silva"]]');
    });

    test('Passing list with a map argument containing one element', () {
      var queryParameters = [
        {'name': 'João Smith'}
      ];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue, '[{"name":"João Smith"}]');
    });

    test('Passing list with primitives and map arguments', () {
      var queryParameters = [
        'City',
        {'name': 'Londrina', 'latitude': -23.31028, 'longitude': -51.16278}
      ];
      var formattedValue = retrolite.formatQueryValueAsList(queryParameters);
      expect(formattedValue,
          '["City",{"name":"Londrina","latitude":-23.31028,"longitude":-51.16278}]');
    });
  });
}
