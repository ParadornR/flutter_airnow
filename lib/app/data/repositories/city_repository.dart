import 'package:flutter_airnow/app/data/models/city_model.dart';
import 'package:flutter_airnow/app/data/providers/city_provider.dart';

class CityRepository {
  final CityApiService apiService;

  CityRepository({required this.apiService});

  Future<CityApiModel> fetchCity(String state, String country) async {
    final response = await apiService.fetchCity(state, country);
    if (response.status.hasError) {
      throw Exception("Error fetching city data");
    } else {
      return CityApiModel.fromJson(response.body);
    }
  }
}
