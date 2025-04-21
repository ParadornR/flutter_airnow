import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/state_controller.dart';
import 'package:get/get.dart';

class GeoController extends GetxController {
  // find
  final stateController = Get.find<StateController>();
  final cityController = Get.find<CityController>();

  var selectedCountryValue = Rx<String?>(null);
  var selectedStateValue = Rx<String?>(null);
  var selectedCityValue = Rx<String?>(null);

  final countryTextEditing = TextEditingController();
  final stateTextEditing = TextEditingController();
  final cityTextEditing = TextEditingController();

  onChangedCountry(value) {
    selectedStateValue.value = null;
    log("selectedCountryValue:$value");
    selectedCountryValue.value = value;
    log("Country:${selectedCountryValue.value}");
    stateController.fetchStates(selectedCountryValue.value);
  }

  onMenuStateChangeCountry(isOpen) {
    if (!isOpen) {
      countryTextEditing.clear();
    }
  }

  onChangedState(value) {
    selectedCityValue.value = null;
    log("selectedStateValue:$value");
    selectedStateValue.value = value;
    log("Country:${selectedCountryValue.value}");
    log("State:${selectedStateValue.string}");
    cityController.loadCity(
      country: selectedCountryValue.value!,
      state: selectedStateValue.value!,
    );
  }

  onMenuStateChangeState(isOpen) {
    if (!isOpen) {
      stateTextEditing.clear();
    }
  }

  onChangedCity(value) {
    log("selectedStateValue:$value");
    selectedCityValue.value = value;
    log("Country:${selectedCountryValue.value}");
    log("State:${selectedStateValue.string}");
    log("City:${selectedCityValue.string}");
  }

  onMenuStateChangeCity(isOpen) {
    if (!isOpen) {
      cityTextEditing.clear();
    }
  }
}
