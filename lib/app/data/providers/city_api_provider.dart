import 'package:get/get.dart';

class CityApiProvider extends GetConnect {
  // ฟังก์ชันที่ดึงข้อมูลจาก API และคืนค่า Response
  Future<Response> fetchCities(
    String state,
    String country,
    String apiKey,
  ) async {
    final url =
        "http://api.airvisual.com/v2/cities?state=$state&country=$country&key=$apiKey";

    try {
      final response = await get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
