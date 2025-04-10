import 'dart:developer';
import 'package:flutter_airnow/app/data/models/state_model.dart';
import 'package:flutter_airnow/app/data/repositories/state_repository.dart';
import 'package:get/get.dart';

class StateProvider extends GetxController {
  final StateRepository _repository = StateRepository();
  final Rxn<StateModel> stateModel = Rxn<StateModel>();
  final RxBool isLoading = false.obs;
  var states = <String>[].obs;

  Future<void> fetchCountry([String countryName = "Thailand"]) async {
    log("countryName:$countryName");
    try {
      isLoading.value = true;
      final data = await _repository.loadCountryOnly(countryName);
      stateModel.value = data;
      states.value = data.data[countryName] ?? [];
      log(" states.value:${states.value}");
    } catch (e) {
      log("Error: $e");
      states.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
