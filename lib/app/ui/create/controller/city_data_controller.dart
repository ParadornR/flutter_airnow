import 'dart:developer';

import 'package:flutter_airnow/app/data/models/city_data_model.dart';
import 'package:flutter_airnow/app/data/providers/city_data_provider.dart';
import 'package:flutter_airnow/app/data/repositories/city_data_repository.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_controller.dart';
import 'package:get/get.dart';

class CityDataController extends GetxController {
  final cityController = Get.find<CityController>();
  late CityDataRepository cityDataRepository;
  var isLoadingcityData = false.obs;
  var cityData = Rx<CityDataModel?>(null);

  @override
  void onInit() {
    super.onInit();
    cityDataRepository = CityDataRepository(apiService: CityDataApiService());
  }

  Future<void> loadDataCityWithCSC({
    required String city,
    required String state,
    required String country,
  }) async {
    log('[loadDataCityWithCSC]: loading...');
    cityController.isLoadingCity.value = true;
    log('[CSC city]: $city');
    log('[CSC state]: $state');
    log('[CSC country]: $country');
    try {
      final result = await cityDataRepository.fetchDataWithCSC(
        city,
        state,
        country,
      );
      cityData.value = result;
      log('[loadDataCity]: succeed');
    } catch (e) {
      log("Error: $e");
    } finally {
      cityController.isLoadingCity.value = false;
    }
  }

  Future<void> loadDataCityWithLocation({
    required String latitude,
    required String longitude,
  }) async {
    log('[loadDataCityWithLocation]: loading...');
    cityController.isLoadingCity.value = true;
    log('[Location latitude]: $latitude');
    log('[Location longitude]: $longitude');
    try {
      final result = await cityDataRepository.fetchDataWithLocation(
        latitude,
        longitude,
      );
      cityData.value = result;
      log('[loadDataCity]: succeed');
    } catch (e) {
      log("Error: $e");
    } finally {
      cityController.isLoadingCity.value = false;
    }
  }
}
