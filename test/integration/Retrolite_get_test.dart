import 'dart:core';
import 'package:retrolite/retrolite.dart';
import 'package:retrolite/src/http/Response.dart';
import 'package:test/test.dart';

import '../../example/retrolite_example.dart';
import '../../example/tmdb/MovieGenres.dart';
import '../../example/tmdb/TmdbApi.dart';

void main()
{
  group('Retrolite.get integration tests', () {

    Retrolite retroliteTmdbApi;
    TmdbApi tmdbApi;

    setUpAll(() {

      retroliteTmdbApi = Retrolite(
          'https://api.themoviedb.org/3/',
          httpClient: newUnsafeHttpClient()
      );

      tmdbApi = retroliteTmdbApi.register<TmdbApi>(
        new TmdbApi('1f54bd990f1cdfb230adb312546d765d')
      );
    });

    test('Get movie genres from TmdbApi', () async {
      Response<MovieGenres> genres = await tmdbApi.genresForMovies();
      expect(genres.value.genres, isNotEmpty);
    });

  });
}
