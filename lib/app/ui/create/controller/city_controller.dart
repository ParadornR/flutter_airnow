import 'dart:developer';

import 'package:flutter_airnow/app/data/models/city_model.dart';
import 'package:flutter_airnow/app/data/providers/city_provider.dart';
import 'package:flutter_airnow/app/data/repositories/city_repository.dart';
import 'package:get/get.dart';

class CityController extends GetxController {
  // loadCity api
  late CityRepository cityRepository;
  var isLoadingCity = false.obs;
  var city = Rx<CityApiModel?>(null);

  @override
  void onInit() {
    super.onInit();
    cityRepository = CityRepository(apiService: CityApiService());
  }

  Future<void> loadCity({
    required String state,
    required String country,
  }) async {
    log('[loadCity]: loadng...');
    isLoadingCity.value = true;
    try {
      final result = await cityRepository.fetchCity(state, country);
      city.value = result;
      log('[loadCity]: succeed');
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoadingCity.value = false;
    }
  }
}
