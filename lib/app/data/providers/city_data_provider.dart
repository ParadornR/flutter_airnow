import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CityDataApiService extends GetConnect {
  final String apiKey = dotenv.env['API_KEY'] ?? "default_api_key"; 
  Future<Response> fetchCityDataWithCityStateCountry(
    String city,
    String state,
    String country,
  ) {
    final url =
        "http://api.airvisual.com/v2/city?city=$city&state=$state&country=$country&key=$apiKey";
    log("[fetchCityDataWithCityStateCountry]:$url");
    return get(url);
  }

  Future<Response> fetchCityDataWithLocation(
    String latitude,
    String longitude,
  ) {
    final url =
        "http://api.airvisual.com/v2/nearest_city?lat=$latitude&lon=$longitude&key=$apiKey";
    return get(url);
  }
}
// class CityDataProvider extends GetxController {
//   late CityDataRepository cityDataRepository;
//   var cityData = Rxn<CityDataModel>();
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     cityDataRepository = CityDataRepository(apiService: CityDataApiService());
//   }

//   void loadCityDataWithCityStateCountry({
//     required String city,
//     required String state,
//     required String country,
//   }) async {
//     isLoading.value = true;
//     try {
//       cityData.value = await cityDataRepository
//           .fetchCityDataWithCityStateCountry(city, state, country);
//       log("cityData: ${cityData.value}");
//     } catch (e) {
//       log("Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void loadCityDataWithLocatiion({
//     required String latitude,
//     required String longitude,
//   }) async {
//     isLoading.value = true;
//     try {
//       cityData.value = await cityDataRepository.fetchCityDataWithLocatiion(
//         latitude,
//         longitude,
//       );
//       log("cityData: ${cityData.value}");
//     } catch (e) {
//       log("Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }  