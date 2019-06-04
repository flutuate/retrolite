import 'dart:collection';

import 'Genre.dart';

class Genres
 extends ListBase<Genre>
{
  final List<Genre> genres;

  Genres(this.genres);

  Genres.fromJson(Map<String, dynamic> json)
      : genres = json['genres'];

  @override
  int get length => genres.length;

  @override
  void set length(int newLength) => genres.length = newLength;

  @override
  Genre operator [](int index) => genres[index];

  @override
  void operator []=(int index, value) => genres[index] = value;

}