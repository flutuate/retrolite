import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.buildUrl tests', () {

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

    test('Building a url with null route throws argument error', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      expect( () => retrolite.buildUrl(null), throwsArgumentError );
    });

    test('Test of building a url with empty route', () {
      final String baseUrl = 'http://localhost:8080';
      var retrolite = Retrolite(baseUrl);
      var route = '';
      var url = retrolite.buildUrl(route);
      expect(url.toString(), equals(baseUrl+'/'+route));
    });

    /// TODO Implement tests using parameter 'queryParameter'

  });
}
