import 'dart:convert';

class DateRange {
  final DateTime minimum;
  final DateTime maximum;

  DateRange.fromJson(Map<String, dynamic> json)
      : minimum = DateTime.parse(json['minimum']),
        maximum = DateTime.parse(json['maximum']);

  static DateRange deserialize(String body) =>
      new DateRange.fromJson(json.decode(body));
}
