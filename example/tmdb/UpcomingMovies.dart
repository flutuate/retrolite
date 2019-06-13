import 'dart:convert';

import 'Dates.dart';
import 'Movie.dart';

//TODO missing 'dates', 'total_pages', 'total_results'.
class UpcomingMovies
{
  final int page;
  final List<Movie> movies = [];
  final Dates dates;

  UpcomingMovies.fromJson(Map<String, dynamic> json)
      : page = json['page']
      , dates = Dates.fromJson(json['dates'])
  {
    var results  = json['results'];
  }

  static UpcomingMovies deserialize(String body)
    => new UpcomingMovies.fromJson(json.decode(body));
}

/*import 'package:collection/collection.dart';

import 'Genre.dart';

class Genres
{
  final List<Genre> genres;

  Genres.fromJson(Map<String, dynamic> json) =>
      _deserializeGenres(json['genresquestoes']);
      : this._();

  @override
  int get length => _genres.length;

  @override
  set length(int newLength) => _genres.length = newLength;

  @override
  Genre operator [](int index) => _genres[index];

  @override
  void operator []=(int index, value) => _genres[index] = value;
}*/

List<Movie> moviesFromJson(Map<String,dynamic> json) {
  List<Movie> movies = [];
  List jsonMovies = json['results'];
  for( var jsonMovie in jsonMovies ) {
    movies.add( new Movie.fromJson(jsonMovie) );
  }
  return movies;
}
