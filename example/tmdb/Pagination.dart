import 'dart:convert';

class Pagination
{
  final int page;
  final int totalPages;
  final int totalResults;

  Pagination.fromJson(Map<String, dynamic> json)
    : page = json['page']
    , totalPages = json['total_pages']
    , totalResults = json['total_results'];

  static Pagination deserialize(String body)
    => new Pagination.fromJson(json.decode(body));
}
