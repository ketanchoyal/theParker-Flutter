import 'dart:convert';

class Location {
    double lat;
    double lng;

    Location({
        this.lat,
        this.lng,
    });

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String fullJSON() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => new Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}