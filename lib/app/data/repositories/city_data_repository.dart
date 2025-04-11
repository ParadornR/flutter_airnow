import 'dart:developer';

import 'package:flutter_airnow/app/data/models/city_data_model.dart';
import 'package:flutter_airnow/app/services/city_data_api_service.dart';

class CityDataRepository {
  final CityDataApiService apiService;

  CityDataRepository({required this.apiService});

  Future<CityDataModel> fetchCityData(
    String city,
    String state,
    String country,
  ) async {
    log("(fetchCityData state):$state");
    log("(fetchCityData country):$country");
    try {
      return await apiService.getCityData(city, state, country);
    } catch (e) {
      rethrow;
    }
  }
}
