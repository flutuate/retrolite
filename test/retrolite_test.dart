import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Build methods of Retrolite tests', () {

    setUp(() {
    });

    test('Test of building an url without a slash ("/") at the end', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var url = retrolite.buildHost();
      expect(url.toString(), equals(baseUrl+'/'));
    });

    test('Test of building an url containing a slash at the end', () {
      final String baseUrl = 'http://localhost:8080/';
      var retrolite = Retrolite(baseUrl);
      var url = retrolite.buildHost();
      expect(url.toString(), equals(baseUrl));
    });

    test('Test of building a url without a slash at the end +endpoint', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.buildUrl(route);
      expect(url.toString(), equals(baseUrl+'/'+route));
    });

    test('Test of building a url containing a slash at the end +endpoint', () {
      final String baseUrl = 'http://localhost:8080/';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.buildUrl(route);
      expect(url.toString(), equals(baseUrl+route));
    });

    test('Test of building a url containing space chars', () {
      final String baseUrl = '       http://localhost:8080               ';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.buildUrl(route);
      expect(url.toString(), equals(baseUrl.trim()+'/'+route));
    });

    test('One primitive query parameter building test', () {
      var retrolite = Retrolite('http://localhost:8080');
      var queryParameters = {
        'id': 1234567
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567');
    });

    test('Testing the construction of a query parameter containing spaces in the name', () {
      var retrolite = Retrolite('http://localhost:8080');
      var queryParameters = {
        '          id           ': 1234567
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567');
    });

    test('Multiples primitive query parameters building test', () {
      var retrolite = Retrolite('http://localhost:8080');
      var queryParameters = {
        'id': 1234567,
        'name': 'João Smith'
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567&name=Jo%C3%A3o+Smith');
    });

    test('Query parameters with string array building test', () {
      var retrolite = Retrolite('http://localhost:8080');
      var queryParameters = {
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ',']
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Query parameters with null value building test', () {
      var retrolite = Retrolite('http://localhost:8080');
      var queryParameters = {
        'valueNull': null,
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ','],
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?valueNull=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Query parameters with double value building test', () {
      var retrolite = Retrolite('http://localhost:8080');
      var queryParameters = {
        'double': 13579.23468,
        'valueNull': null,
        'id': 1234567,
        'name': 'João Smith',
        'phones': ['+554733331234', '+14561234', ','],
      };
      var parameters = retrolite.buildQueryParameters(queryParameters);
      expect(parameters, '?double=13579.23468&valueNull=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
    });

    test('Query parameters with empty value building test', () {
      var retrolite = Retrolite('http://localhost:8080');
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
      var retrolite = Retrolite('http://localhost:8080');
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
