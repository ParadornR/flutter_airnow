import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CityApiService extends GetConnect {
  final String apiKey =
      dotenv.env['API_KEY'] ??
      "default_api_key"; // ใช้ default value เมื่อไม่ได้ตั้งค่า
  Future<Response> fetchCity(String state, String country) {
    final url =
        "http://api.airvisual.com/v2/cities?state=$state&country=$country&key=$apiKey";
    return get(url);
  }
}
