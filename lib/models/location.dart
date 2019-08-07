import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'location_fact.dart';
import '../endpoint.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final List<LocationFact> facts;
  
  Location({this.id, this.name, this.url, this.facts});

  Location.blank(): id = 0, name = '', url = '', facts = [];

  factory Location.fromJson(Map<String, dynamic> json) {
    return _$LocationFromJson(json);
  }

  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/locations');
    final response = await http.get(uri.toString());
    if (response.statusCode != 200) {
      throw response.body;
    }
    List<Location> locations = <Location>[];
    for (var jsonItem in json.decode(response.body)) {
      locations.add(Location.fromJson(jsonItem));
    }
    return locations;
  }

  static Future<Location> fetchById(int id) async {
    var uri = Endpoint.uri('/locations/$id');
    final response = await http.get(uri.toString());
    if (response.statusCode != 200) {
      throw response.body;
    }
    return Location.fromJson(json.decode(response.body));
  }

}
