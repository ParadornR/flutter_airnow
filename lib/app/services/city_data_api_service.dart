import 'package:flutter_airnow/app/data/models/city_data_model.dart';
import 'dart:convert';

import 'package:get/get_connect/connect.dart';

class CityDataApiService extends GetConnect {
  final String apiKey = "a4547916-d95f-4d43-b0ef-3bcdc2bf1011";

  Future<CityDataModel> getCityData(
    String city,
    String state,
    String country,
  ) async {
    final url =
        "http://api.airvisual.com/v2cities?city=$city&state=$state&country=$country&key=$apiKey";
    final response = await get(url);

    if (response.statusCode == 200) {
      return CityDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load city data');
    }
  }
}
