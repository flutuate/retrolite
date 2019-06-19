import 'dart:convert';

class Pagination {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  Pagination.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        perPage = json['per_page'],
        totalPages = json['total_pages'],
        total = json['total'];

  static Pagination deserialize(String body) =>
      new Pagination.fromJson(json.decode(body));
}
