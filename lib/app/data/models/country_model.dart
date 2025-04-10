class CountryModel {
  List<Country> data;

  CountryModel({required this.data});

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Country {
  String country;

  Country({required this.country});

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(country: json["country"]);

  Map<String, dynamic> toJson() => {"country": country};
}
