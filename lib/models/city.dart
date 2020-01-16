import 'dart:ffi';

class City {
  final int id;
  final String name;
  final String country;

  City(this.id, this.name, this.country);

  City.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    name = json['name'],
    country = json['country'];

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'name': name,
    'country': country
  };
}