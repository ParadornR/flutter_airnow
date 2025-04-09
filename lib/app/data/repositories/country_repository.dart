import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_airnow/app/data/models/country_model.dart';

class CountryRepository {
  Future<List<Country>> getCountries() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/countries.json',
      );
      final data = json.decode(response)['data'];
      return List<Country>.from(data.map((item) => Country.fromJson(item)));
    } catch (e) {
      rethrow;
    }
  }
}
