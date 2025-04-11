class CityApiModel {
  final String status;
  final List<City> data;

  CityApiModel({required this.status, required this.data});

  factory CityApiModel.fromJson(Map<String, dynamic> json) => CityApiModel(
    status: json["status"],
    data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class City {
  final String city;

  City({required this.city});

  factory City.fromJson(Map<String, dynamic> json) => City(city: json["city"]);

  Map<String, dynamic> toJson() => {"city": city};
}
