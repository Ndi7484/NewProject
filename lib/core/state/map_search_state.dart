// To parse this JSON data, do
//
//     final mapSearchState = mapSearchStateFromJson(jsonString);

import 'dart:convert';

List<MapSearchState> mapSearchStateFromJson(String str) => List<MapSearchState>.from(json.decode(str).map((x) => MapSearchState.fromJson(x)));

String mapSearchStateToJson(List<MapSearchState> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapSearchState {
    int placeId;
    // String licence;
    // OsmType osmType;
    // int osmId;
    String lat;
    String lon;
    String mapSearchStateClass;
    // String type;
    // int placeRank;
    // double importance;
    // String addresstype;
    // String name;
    String displayName;
    Address address;
    // List<String> boundingbox;
    // Geojson geojson;

    MapSearchState({
        required this.placeId,
        // required this.licence,
        // required this.osmType,
        // required this.osmId,
        required this.lat,
        required this.lon,
        required this.mapSearchStateClass,
        // required this.type,
        // required this.placeRank,
        // required this.importance,
        // required this.addresstype,
        // required this.name,
        required this.displayName,
        required this.address,
        // required this.boundingbox,
        // required this.geojson,
    });

    factory MapSearchState.fromJson(Map<String, dynamic> json) => MapSearchState(
        placeId: json["place_id"],
        // licence: json["licence"],
        // osmType: osmTypeValues.map[json["osm_type"]]!,
        // osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        mapSearchStateClass: json["class"],
        // type: json["type"],
        // placeRank: json["place_rank"],
        // importance: json["importance"]?.toDouble(),
        // addresstype: json["addresstype"],
        // name: json["name"],
        displayName: json["display_name"],
        address: Address.fromJson(json["address"]),
        // boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
        // geojson: Geojson.fromJson(json["geojson"]),
    );

    Map<String, dynamic> toJson() => {
        "place_id": placeId,
        // "licence": licence,
        // "osm_type": osmTypeValues.reverse[osmType],
        // "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "class": mapSearchStateClass,
        // "type": type,
        // "place_rank": placeRank,
        // "importance": importance,
        // "addresstype": addresstype,
        // "name": name,
        "display_name": displayName,
        "address": address.toJson(),
        // "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
        // "geojson": geojson.toJson(),
    };
}

class Address {
    // String? hamlet;
    // String? county;
    // String? stateDistrict;
    // String? state;
    // String iso31662Lvl4;
    String? postcode;
    String country;
    String countryCode;
    // String? village;
    // String? waterway;
    // String? road;
    // String? neighbourhood;
    // String? city;
    // String? district;
    // String? town;
    // String? province;
    // String? region;
    // String? natural;
    // String? archipelago;
    // String? iso31662Lvl3;

    Address({
        // this.hamlet,
        // this.county,
        // this.stateDistrict,
        // this.state,
        // required this.iso31662Lvl4,
        this.postcode,
        required this.country,
        required this.countryCode,
        // this.village,
        // this.waterway,
        // this.road,
        // this.neighbourhood,
        // this.city,
        // this.district,
        // this.town,
        // this.province,
        // this.region,
        // this.natural,
        // this.archipelago,
        // this.iso31662Lvl3,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        // hamlet: json["hamlet"],
        // county: json["county"],
        // stateDistrict: json["state_district"],
        // state: json["state"],
        // iso31662Lvl4: json["ISO3166-2-lvl4"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
        // village: json["village"],
        // waterway: json["waterway"],
        // road: json["road"],
        // neighbourhood: json["neighbourhood"],
        // city: json["city"],
        // district: json["district"],
        // town: json["town"],
        // province: json["province"],
        // region: json["region"],
        // natural: json["natural"],
        // archipelago: json["archipelago"],
        // iso31662Lvl3: json["ISO3166-2-lvl3"],
    );

    Map<String, dynamic> toJson() => {
        // "hamlet": hamlet,
        // "county": county,
        // "state_district": stateDistrict,
        // "state": state,
        // "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
        // "village": village,
        // "waterway": waterway,
        // "road": road,
        // "neighbourhood": neighbourhood,
        // "city": city,
        // "district": district,
        // "town": town,
        // "province": province,
        // "region": region,
        // "natural": natural,
        // "archipelago": archipelago,
        // "ISO3166-2-lvl3": iso31662Lvl3,
    };
}

class Geojson {
    Type type;
    List<dynamic> coordinates;

    Geojson({
        required this.type,
        required this.coordinates,
    });

    factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
        type: typeValues.map[json["type"]]!,
        coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

enum Type {
    LINE_STRING,
    POINT
}

final typeValues = EnumValues({
    "LineString": Type.LINE_STRING,
    "Point": Type.POINT
});

enum OsmType {
    NODE,
    WAY
}

final osmTypeValues = EnumValues({
    "node": OsmType.NODE,
    "way": OsmType.WAY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
