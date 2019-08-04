import 'package:json_annotation/json_annotation.dart';
import 'location_fact.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final List<LocationFact> facts;
  
  Location({this.id, this.name, this.url, this.facts});

  factory Location.fromJson(Map<String, dynamic> json) {
    return _$LocationFromJson(json);
  }

}
