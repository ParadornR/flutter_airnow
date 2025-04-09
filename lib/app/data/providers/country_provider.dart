import 'dart:developer';

import 'package:flutter_airnow/app/data/models/country_model.dart';
import 'package:flutter_airnow/app/data/repositories/country_repository.dart';
import 'package:get/get.dart';

class CountryProvider extends GetxController {
  var countries = <Country>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final CountryRepository _countryRepository = CountryRepository();

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  void fetchCountries() async {
    try {
      isLoading(true);
      final Welcome welcomeData = await _countryRepository.getCountries();
      countries.assignAll(welcomeData.data);
      log("countries: $countries");
    } catch (e) {
      errorMessage.value = 'Failed to load countries';
    } finally {
      isLoading(false);
    }
  }
}
