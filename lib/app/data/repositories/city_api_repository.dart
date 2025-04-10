import 'package:flutter_airnow/app/data/providers/city_api_provider.dart';
import 'package:flutter_airnow/app/data/models/city_api_model.dart';

class CityRepository {
  final CityApiProvider apiProvider;

  CityRepository({required this.apiProvider});

  // ฟังก์ชันที่ดึงข้อมูลจาก API ผ่าน Provider
  Future<CityApiModel?> fetchCities(
    String state,
    String country,
    String apiKey,
  ) async {
    try {
      // เรียกใช้ fetchCities จาก apiProvider พร้อมส่งพารามิเตอร์
      final response = await apiProvider.fetchCities(state, country, apiKey);

      if (response.statusCode == 200) {
        // แปลงข้อมูลจาก JSON เป็น CityApiModel
        return CityApiModel.fromJson(response.body);
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      throw Exception('Failed to load cities');
    }
  }
}
