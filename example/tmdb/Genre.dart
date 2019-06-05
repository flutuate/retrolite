class Genre
{
  final int id;
  final String name;

  Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id']
      , name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
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

List<Genre> genresFromJson(Map<String,dynamic> json) {
  List<Genre> genres = [];
  List jsonGenres = json['genres'];
  for( var jsonGenre in jsonGenres ) {
    genres.add( new Genre.fromJson(jsonGenre) );
  }
  return genres;
}
