import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Build methods of Retrolite tests', () {

    setUp(() {
    });

    test('Url host build without slash ("/") at end', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var url = retrolite.buildHost();
      expect(url.toString(), equals(baseUrl+'/'));
    });

    test('Url host building with slash ("/") at end', () {
      final String baseUrl = 'http://localhost:8080/';
      var retrolite = Retrolite(baseUrl);
      var url = retrolite.buildHost();
      expect(url.toString(), equals(baseUrl));
    });

    test('Url building without slash ("/") at end', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.buildUrl(route);
      expect(url.toString(), equals(baseUrl+'/'+route));
    });

    test('Url building with slash ("/") at end', () {
      final String baseUrl = 'http://localhost:8080/';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.buildUrl(route);
      expect(url.toString(), equals(baseUrl+route));
    });

    test('Url building with space chars at end', () {
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


  });
}
