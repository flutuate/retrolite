import 'dart:convert';

import 'Dates.dart';
import 'Movie.dart';
import 'Pagination.dart';

class UpcomingMovies extends Pagination {
  final List<Movie> movies;
  final DateRange dates;

  UpcomingMovies.fromJson(Map<String, dynamic> json)
      : dates = DateRange.fromJson(json['dates']),
        movies = moviesFromJson(json['results']),
        super.fromJson(json);

  static UpcomingMovies deserialize(String body) =>
      new UpcomingMovies.fromJson(json.decode(body));

  static List<Movie> moviesFromJson(List jsonMovies) {
    List<Movie> movies = [];
    for (var jsonMovie in jsonMovies) {
      movies.add(new Movie.fromJson(jsonMovie));
    }
    return movies;
  }
}
