import 'dart:convert';

import 'Genre.dart';

class MovieGenres {
  final List<Genre> genres = [];

  MovieGenres.fromJson(Map<String, dynamic> mapJson) {
    List jsonGenres = mapJson['genres'];
    for (var jsonGenre in jsonGenres) {
      genres.add(Genre.fromJson(jsonGenre));
    }
  }

  static MovieGenres deserialize(String body) =>
      new MovieGenres.fromJson(json.decode(body));
}
