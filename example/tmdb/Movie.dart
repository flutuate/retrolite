class Movie
{
  final int id;
  final String title;

  Movie(this.id, this.title);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id']
      , title = json['title'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': title,
      };
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
