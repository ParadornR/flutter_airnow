class CityDataModel {
  final String status;
  final Data data;

  CityDataModel({required this.status, required this.data});

  factory CityDataModel.fromJson(Map<String, dynamic> json) =>
      CityDataModel(status: json["status"], data: Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"status": status, "data": data.toJson()};
}

class Data {
  final String city;
  final String state;
  final String country;
  final Location location;
  final Current current;

  Data({
    required this.city,
    required this.state,
    required this.country,
    required this.location,
    required this.current,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    city: json["city"],
    state: json["state"],
    country: json["country"],
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "state": state,
    "country": country,
    "location": location.toJson(),
    "current": current.toJson(),
  };
}

class Current {
  final Pollution pollution;
  final Weather weather;

  Current({required this.pollution, required this.weather});

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    pollution: Pollution.fromJson(json["pollution"]),
    weather: Weather.fromJson(json["weather"]),
  );

  Map<String, dynamic> toJson() => {
    "pollution": pollution.toJson(),
    "weather": weather.toJson(),
  };
}

class Pollution {
  final String ts;
  final int aqius;
  final String mainus;
  final int aqicn;
  final String maincn;

  Pollution({
    required this.ts,
    required this.aqius,
    required this.mainus,
    required this.aqicn,
    required this.maincn,
  });

  factory Pollution.fromJson(Map<String, dynamic> json) => Pollution(
    ts: json["ts"],
    aqius: json["aqius"],
    mainus: json["mainus"],
    aqicn: json["aqicn"],
    maincn: json["maincn"],
  );

  Map<String, dynamic> toJson() => {
    "ts": ts,
    "aqius": aqius,
    "mainus": mainus,
    "aqicn": aqicn,
    "maincn": maincn,
  };
}

class Weather {
  final String ts;
  final int tp;
  final int pr;
  final int hu;
  final double ws;
  final int wd;
  final String ic;

  Weather({
    required this.ts,
    required this.tp,
    required this.pr,
    required this.hu,
    required this.ws,
    required this.wd,
    required this.ic,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    ts: json["ts"],
    tp: json["tp"],
    pr: json["pr"],
    hu: json["hu"],
    ws: json["ws"]?.toDouble(),
    wd: json["wd"],
    ic: json["ic"],
  );

  Map<String, dynamic> toJson() => {
    "ts": ts,
    "tp": tp,
    "pr": pr,
    "hu": hu,
    "ws": ws,
    "wd": wd,
    "ic": ic,
  };
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: List<double>.from(
      json["coordinates"].map((x) => x?.toDouble()),
    ),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}
