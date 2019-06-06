import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.buildUrl tests', () {

    test('Build an url without a slash at the end +endpoint', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.parseUrl(route);
      expect(url.toString(), '$baseUrl/$route');
    });

    test('Build an url containing a slash at the end +endpoint', () {
      final String baseUrl = 'http://localhost:8080/';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.parseUrl(route);
      expect(url.toString(), '$baseUrl$route');
    });

    test('Build an url containing space chars', () {
      final String baseUrl = '       http://localhost:8080               ';
      var retrolite = Retrolite(baseUrl);
      var route = 'client/test';
      var url = retrolite.parseUrl(route);
      expect(url.toString(), '${baseUrl.trim()}/$route');
    });

    test('Build an url with null route throws argument error', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      expect( () => retrolite.parseUrl(null), throwsArgumentError );
    });

    test('Build an url with empty route', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = '';
      var url = retrolite.parseUrl(route);
      expect(url.toString(), '$baseUrl/$route');
    });

    test('Build an url with primitive query parameters', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = '/test';
      var url = retrolite.parseUrl(
          route,
          {'id':123, 'name':'João Smith', 'height': 1.81}
      );
      expect(url.toString(), '$baseUrl/$route?id=123&name=Jo%C3%A3o+Smith&height=1.81');
    });

    test('Build an url with primitives and list query parameters', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = '/test';
      var url = retrolite.parseUrl(
          route,
          {'id':123, 'name':'João Smith', 'height': 1.81, 'list': ['abc', 123, 456.789]}
      );
      expect(url.toString(), '$baseUrl/$route?id=123&name=Jo%C3%A3o+Smith&height=1.81&list=%5B%22abc%22%2C123%2C456.789%5D');
    });

    test('Build an url with primitives, list and map query parameters', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = '/test';
      var url = retrolite.parseUrl(
          route,
          {'id':123, 'name':'João Smith', 'height': 1.81, 'list': ['abc', 123, 456.789], 'map':{'v1':1,'v2':'x','v3':5.67}}
      );
      expect(url.toString(), '$baseUrl/$route?id=123&name=Jo%C3%A3o+Smith&height=1.81&list=%5B%22abc%22%2C123%2C456.789%5D&map=%7B%22v1%22%3A1%2C%22v2%22%3A%22x%22%2C%22v3%22%3A5.67%7D');
    });

  });
}
