import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_airnow/app/data/providers/state_provider.dart';
import 'package:get/get.dart';

class GeoController extends GetxController {
  final stateProviser = Get.find<StateProvider>();

  var selectedCountryValue = Rx<String?>(null);
  var selectedStateValue = Rx<String?>(null);
  var selectedCityValue = Rx<String?>(null);

  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  onChangedCountry(value) {
    selectedStateValue.value = null;
    log("selectedCountryValue:$value");
    selectedCountryValue.value = value as String?;
    log("Country:${selectedCountryValue.value}");
    stateProviser.fetchState(selectedCountryValue.value);
  }

  onMenuStateChangeCountry(isOpen) {
    if (!isOpen) {
      countryController.clear();
    }
  }

  onChangedState(value) {
    log("selectedStateValue:$value");
    selectedStateValue.value = value as String?;
    log("Country:${selectedCountryValue.value}");
    log("State:${selectedStateValue.string}");
  }

  onMenuStateChangeState(isOpen) {
    if (!isOpen) {
      stateController.clear();
    }
  }

  onChangedCity(value) {
    log("selectedStateValue:$value");
    selectedCityValue.value = value as String?;
    log("Country:${selectedCountryValue.value}");
    log("State:${selectedStateValue.string}");
    log("State:${selectedCityValue.string}");
  }

  onMenuStateChangeCity(isOpen) {
    if (!isOpen) {
      stateController.clear();
    }
  }
}
