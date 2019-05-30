import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.buildHost tests', () {

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

  });
}
