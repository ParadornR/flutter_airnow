import 'dart:developer';

import 'package:flutter_airnow/app/data/models/city_model.dart';
import 'package:get/get_connect/connect.dart';

class CityApiService extends GetConnect {
  final String apiKey = "a4547916-d95f-4d43-b0ef-3bcdc2bf1011";

  Future<CityApiModel> getCity(String state, String country) async {
    log("(fetchCityData state):$state");
    log("(fetchCityData country):$country");

    final url =
        "http://api.airvisual.com/v2/cities?state=$state&country=$country&key=$apiKey";
    final response = await get(url);

    log("[getCity statusCode]: ${response.statusCode}");
    log("[getCity body]: ${response.body}");

    if (response.statusCode == 200) {
      return CityApiModel.fromJson(response.body);
    } else {
      throw Exception("Failed to load city data");
    }
  }
}
