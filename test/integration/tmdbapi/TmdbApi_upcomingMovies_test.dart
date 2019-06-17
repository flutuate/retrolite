import 'dart:core';
import 'package:retrolite/retrolite.dart';
import 'package:retrolite/src/http/Response.dart';
import 'package:test/test.dart';

import '../../../example/retrolite_example.dart';
import '../../../example/tmdb/TmdbApi.dart';
import '../../../example/tmdb/UpcomingMovies.dart';

void main()
{
  group('TmdbApi integration tests', () {

    Retrolite retrolite;
    TmdbApi tmdbApi;

    setUpAll(() {

      retrolite = Retrolite(
          'https://api.themoviedb.org/3/',
          httpClient: newUnsafeHttpClient()
      );

      tmdbApi = retrolite.register<TmdbApi>(
        new TmdbApi('1f54bd990f1cdfb230adb312546d765d')
      );
    });

    test('Get upcoming movies', () async {
      Response<UpcomingMovies> upcomingMovies = await tmdbApi.upcomingMovies();
      expect(upcomingMovies.value.movies, isNotEmpty);
    });

  });
}
