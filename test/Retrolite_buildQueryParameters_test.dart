import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Build methods of Retrolite tests', () {

    var retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost:8080');
    });

    test('buildQueryParameters with parameter null must returns empty string', () {
      var parameters = retrolite.buildQueryParameters(null);
      expect(parameters, isEmpty);
    });

    test('Test buildQueryParameters with one element', () {
      var queryParameters = {
        'id': 1234567
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567');
    });

    test('Parameter with spaces in the name will be trimmed', () {
      var queryParameters = {
        '          id           ': 1234567
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567');
    });

    test('Test buildQueryParameters with latin characters in values', () {
      var queryParameters = {
        'id': 1234567,
        'name': 'João Smith'
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567&name=Jo%C3%A3o+Smith');
    });

    test('Test buildQueryParameters with one string array only', () {
      var queryParameters = {
        'phones': ['+554733331234', '+14561234']
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%5D');
    });

    test('Test buildQueryParameters with one dynamic array', () {
      var queryParameters = {
        'values': ['+554733331234', 13579.02468, 54321]
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?values=%5B%22%2B554733331234%22%2C13579.02468%2C54321%5D');
    });

    test('Test buildQueryParameters with one dynamic array', () {
      var queryParameters = {
        'values': ['John Smith', {'age':45} ]
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?values=%5B%22John+Smith%22%2C%7B%22age%22%3A45%7D%5D');
    });


    test('Test buildQueryParameters with string array', () {
      var queryParameters = {
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ',']
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Query parameters with null value building test', () {
      var queryParameters = {
        'nullValue': null,
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ','],
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?nullValue=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Query parameters with double value building test', () {
      var queryParameters = {
        'double': 13579.23468,
        'nullValue': null,
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ','],
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?double=13579.23468&nullValue=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Query parameters with empty value building test', () {
      var queryParameters = {
        'emptyValue': '',
        'double': 13579.23468,
        'nullValue': null,
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ','],
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?emptyValue=&double=13579.23468&nullValue=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Test of building a query parameter containing a map as value', () {
      var queryParameters = {
        'city': {
          'name': 'Londrina',
          'latitude': -23.31028,
          'longitude': -51.16278
        }
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?city=%7B%22name%22%3A%22Londrina%22%2C%22latitude%22%3A-23.31028%2C%22longitude%22%3A-51.16278%7D');
    });

  });
}
