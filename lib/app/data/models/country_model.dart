class Welcome {
  List<Country> data;

  Welcome({required this.data});

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
