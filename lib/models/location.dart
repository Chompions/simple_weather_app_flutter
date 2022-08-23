import 'dart:convert';

List<Location> locationFromJson(String json) =>
    List<Location>.from(jsonDecode(json).map((e) => Location.fromJson(e)));

class Location {
  Location(
    this.nid,
    this.parentNid,
    this.name,
    this.latitude,
    this.longitude,
  );

  int nid;
  int parentNid;
  String name;
  double latitude;
  double longitude;

  Location.fromJson(Map<String, dynamic> json)
      : nid = json["nid"],
        parentNid = json["parent_nid"],
        name = json["name"],
        latitude = json["latitude"].toDouble(),
        longitude = json["longitude"].toDouble();
}
