import 'dart:developer';

import 'package:flutter_airnow/app/data/models/city_model.dart';
import 'package:flutter_airnow/app/services/city_api_service.dart';

class CityRepository {
  final CityApiService apiService;

  CityRepository({required this.apiService});

  Future<CityApiModel> fetchCity(String state, String country) async {
    log("(fetchCityData state):$state");
    log("(fetchCityData country):$country");
    try {
      return await apiService.getCity(state, country);
    } catch (e) {
      rethrow;
    }
  }
}
