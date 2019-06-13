import 'dart:convert';

class Dates
{
  final String minimum;
  final String maximum;

  Dates.fromJson(Map<String, dynamic> json)
    : minimum = json['minimum']
    , maximum = json['maximum'];

  Map<String, dynamic> toJson() =>
      {
        'minimum': minimum,
        'maximum': maximum,
      };

  static Dates deserialize(String body)
    => new Dates.fromJson(json.decode(body));
}
