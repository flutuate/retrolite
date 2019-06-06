import 'Genre.dart';

class MovieGenres
{
  final List<Genre> genres = [];

  MovieGenres.fromJson(Map<String, dynamic> mapJson) {
    List jsonGenres = mapJson['genres'];
    for( var jsonGenre in jsonGenres ) {
      genres.add( Genre.fromJson(jsonGenre) );
    }
  }
}
