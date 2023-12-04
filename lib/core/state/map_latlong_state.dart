// To parse this JSON data, do
//
//     final mapLatLong = mapLatLongFromJson(jsonString);

import 'dart:convert';

MapLatLong mapLatLongFromJson(String str) => MapLatLong.fromJson(json.decode(str));

String mapLatLongToJson(MapLatLong data) => json.encode(data.toJson());

class MapLatLong {
    List<Datum> data;

    MapLatLong({
        required this.data,
    });

    factory MapLatLong.fromJson(Map<String, dynamic> json) => MapLatLong(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    double latitude;
    double longitude;
    Type type;
    double distance;
    String name;
    dynamic number;
    dynamic postalCode;
    String? street;
    double confidence;
    Region region;
    RegionCode regionCode;
    County county;
    County locality;
    dynamic administrativeArea;
    dynamic neighbourhood;
    Country country;
    CountryCode countryCode;
    Continent continent;
    String label;

    Datum({
        required this.latitude,
        required this.longitude,
        required this.type,
        required this.distance,
        required this.name,
        required this.number,
        required this.postalCode,
        required this.street,
        required this.confidence,
        required this.region,
        required this.regionCode,
        required this.county,
        required this.locality,
        required this.administrativeArea,
        required this.neighbourhood,
        required this.country,
        required this.countryCode,
        required this.continent,
        required this.label,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        type: typeValues.map[json["type"]]!,
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        number: json["number"],
        postalCode: json["postal_code"],
        street: json["street"],
        confidence: json["confidence"]?.toDouble(),
        region: regionValues.map[json["region"]]!,
        regionCode: regionCodeValues.map[json["region_code"]]!,
        county: countyValues.map[json["county"]]!,
        locality: countyValues.map[json["locality"]]!,
        administrativeArea: json["administrative_area"],
        neighbourhood: json["neighbourhood"],
        country: countryValues.map[json["country"]]!,
        countryCode: countryCodeValues.map[json["country_code"]]!,
        continent: continentValues.map[json["continent"]]!,
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "type": typeValues.reverse[type],
        "distance": distance,
        "name": name,
        "number": number,
        "postal_code": postalCode,
        "street": street,
        "confidence": confidence,
        "region": regionValues.reverse[region],
        "region_code": regionCodeValues.reverse[regionCode],
        "county": countyValues.reverse[county],
        "locality": countyValues.reverse[locality],
        "administrative_area": administrativeArea,
        "neighbourhood": neighbourhood,
        "country": countryValues.reverse[country],
        "country_code": countryCodeValues.reverse[countryCode],
        "continent": continentValues.reverse[continent],
        "label": label,
    };
}

enum Continent {
    ASIA
}

final continentValues = EnumValues({
    "Asia": Continent.ASIA
});

enum Country {
    INDONESIA
}

final countryValues = EnumValues({
    "Indonesia": Country.INDONESIA
});

enum CountryCode {
    IDN
}

final countryCodeValues = EnumValues({
    "IDN": CountryCode.IDN
});

enum County {
    MEDAN
}

final countyValues = EnumValues({
    "Medan": County.MEDAN
});

enum Region {
    NORTH_SUMATRA
}

final regionValues = EnumValues({
    "North Sumatra": Region.NORTH_SUMATRA
});

enum RegionCode {
    SU
}

final regionCodeValues = EnumValues({
    "SU": RegionCode.SU
});

enum Type {
    VENUE
}

final typeValues = EnumValues({
    "venue": Type.VENUE
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
