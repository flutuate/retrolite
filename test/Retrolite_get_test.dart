import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

import '../example/retrolite_example.dart';
import '../example/tmdb/TmdbApi.dart';

void main() {
  group('Retrolite.buildHost tests', () {

    Retrolite retrolite;

    setUpAll(() {
      retrolite = Retrolite(
        'https://api.themoviedb.org/3/',
        httpClient: newHttpClient(), //newUnsafeHttpClient()
      );

      TmdbApi api = retrolite.register<TmdbApi>( new TmdbApi('<use-your-token>') );
      //TODO
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

  });
}
