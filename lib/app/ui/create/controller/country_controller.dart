import 'package:flutter_airnow/app/data/models/country_model.dart';
import 'package:flutter_airnow/app/data/repositories/country_repository.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final CountryRepository _repository = CountryRepository();
  var countries = <Country>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  void fetchCountries() async {
    isLoading(true);
    try {
      final result = await _repository.getCountries();
      countries.assignAll(result.data);
    } catch (e) {
      errorMessage.value = 'Failed to load countries';
    } finally {
      isLoading(false);
    }
  }
}
