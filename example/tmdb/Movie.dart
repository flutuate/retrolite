import 'dart:convert';

import 'package:retrolite/Double.dart';

class Movie {
  final String posterPath;
  final bool forAdults;
  final String overview;
  final DateTime releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final bool hasVideo;
  final double voteAverage;

  Movie.fromJson(Map<String, dynamic> json)
      : posterPath = json['poster_path'],
        forAdults = json['adult'],
        overview = json['overview'],
        releaseDate = DateTime.parse(json['release_date']),
        genreIds = genreIdsFromJson(json['genre_ids']),
        id = json['id'],
        originalTitle = json['original_title'],
        originalLanguage = json['original_language'],
        title = json['title'],
        backdropPath = json['backdrop_path'],
        popularity = Double.parse(json['popularity']),
        voteCount = json['vote_count'],
        hasVideo = json['video'],
        voteAverage = Double.parse(json['vote_average']);

  static Movie deserialize(String body) =>
      new Movie.fromJson(json.decode(body));

  static List<int> genreIdsFromJson(List jsonGenreIds) {
    List<int> genreIds = [];
    for (var jsonGenreId in jsonGenreIds) {
      genreIds.add(jsonGenreId);
    }
    return genreIds;
  }
}
