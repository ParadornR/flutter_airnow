import 'dart:developer';
import 'package:flutter_airnow/app/data/models/city_data_model.dart';
import 'package:flutter_airnow/app/data/providers/city_data_provider.dart';

class CityDataRepository {
  final CityDataApiService apiService;

  CityDataRepository({required this.apiService});

  // ฟังก์ชันที่ดึงข้อมูลจาก API
  Future<CityDataModel> fetchDataWithCSC(
    String city,
    String state,
    String country,
  ) async {
    log("[fetchDataWithCSC city]:$city");
    log("[fetchDataWithCSC state]:$state");
    log("[fetchDataWithCSC country]:$country");
    try {
      final response = await apiService.fetchCityDataWithCityStateCountry(
        city,
        state,
        country,
      );
      if (response.isOk) {
        return CityDataModel.fromJson(response.body);
      } else {
        throw Exception('Failed to load city data');
      }
    } catch (e) {
      rethrow; // ทำการโยนข้อผิดพลาดกลับ
    }
  }

  // ฟังก์ชันสำหรับดึงข้อมูลตามพิกัด (latitude, longitude)
  Future<CityDataModel> fetchDataWithLocation(
    String latitude,
    String longitude,
  ) async {
    log("[fetchDataWithLocation latitude]:$latitude");
    log("[fetchDataWithLocation longitude]:$longitude");
    try {
      final response = await apiService.fetchCityDataWithLocation(
        latitude,
        longitude,
      );
      if (response.isOk) {
        return CityDataModel.fromJson(response.body);
      } else {
        throw Exception('Failed to load city data by location');
      }
    } catch (e) {
      rethrow; // ทำการโยนข้อผิดพลาดกลับ
    }
  }
}
