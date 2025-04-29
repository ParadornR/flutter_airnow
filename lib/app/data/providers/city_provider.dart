import 'package:get/get.dart';

class CityApiService extends GetConnect {
  final String apiKey = "a4547916-d95f-4d43-b0ef-3bcdc2bf1011";
  Future<Response> fetchCity(String state, String country) {
    final url =
        "http://api.airvisual.com/v2/cities?state=$state&country=$country&key=$apiKey";
    return get(url);
  }
}
