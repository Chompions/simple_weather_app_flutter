import 'dart:convert';

List<Location> locationFromJson(String json) =>
    List<Location>.from(jsonDecode(json).map((e) => Location.fromJson(e)));

class Location {
  Location({
    required this.nid,
    required this.parentNid,
    required this.name,
    this.latitude,
    this.longitude,
  });

  int nid;
  int parentNid;
  String name;
  num? latitude;
  num? longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        nid: json["nid"],
        parentNid: json["parent_nid"],
        name: json["name"],
        latitude: (json["latitude"] ?? 0),
        longitude: (json["longitude"] ?? 0),
      );
}
