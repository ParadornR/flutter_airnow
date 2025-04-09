class Country {
  final String country;

  Country({required this.country});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(country: json['country']);
  }
}
