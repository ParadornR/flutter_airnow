import 'dart:developer';

import 'package:flutter_airnow/app/data/models/state_model.dart';
import 'package:flutter_airnow/app/data/repositories/state_repository.dart';
import 'package:get/get.dart';

class StateController extends GetxController {
  // state in Countries data json
  final StateRepository _statesRepository = StateRepository();

  final Rxn<StateModel> stateModel = Rxn<StateModel>();
  final RxList<String> states = <String>[].obs;
  final RxBool isLoadingState = false.obs;

  Future<void> fetchStates(String? countryName) async {
    log('[fetchStates]: loadng...');
    try {
      isLoadingState.value = true;
      final data = await _statesRepository.getStates(countryName ?? "");
      stateModel.value = data;
      states.assignAll(data.data[countryName] ?? []);
      log('[fetchStates]: succeed');
    } catch (e) {
      log("Error loading states: $e");
      states.clear();
    } finally {
      isLoadingState.value = false;
    }
  }
}
