import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_airnow/app/data/models/country_model.dart';

class CountryRepository {
  Future<Welcome> getCountries() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/countries.json',
      );
      final data = json.decode(response);
      return Welcome.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
