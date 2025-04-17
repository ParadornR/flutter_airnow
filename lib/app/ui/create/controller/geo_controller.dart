import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_airnow/app/data/providers/city_provider.dart';
import 'package:flutter_airnow/app/data/providers/state_provider.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class GeoController extends GetxController {
  // find
  final stateProviser = Get.find<StateProvider>();
  final cityProvider = Get.find<CityProvider>();
  final userProvider = Get.find<UserProvider>();

  var selectedCountryValue = Rx<String?>(null);
  var selectedStateValue = Rx<String?>(null);
  var selectedCityValue = Rx<String?>(null);

  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  onChangedCountry(value) {
    selectedStateValue.value = null;
    log("selectedCountryValue:$value");
    selectedCountryValue.value = value;
    log("Country:${selectedCountryValue.value}");
    stateProviser.fetchState(selectedCountryValue.value);
  }

  onMenuStateChangeCountry(isOpen) {
    if (!isOpen) {
      countryController.clear();
    }
  }

  onChangedState(value) {
    selectedCityValue.value = null;
    log("selectedStateValue:$value");
    selectedStateValue.value = value;
    log("Country:${selectedCountryValue.value}");
    log("State:${selectedStateValue.string}");
    cityProvider.loadCity(
      selectedStateValue.value!,
      selectedCountryValue.value!,
    );
  }

  onMenuStateChangeState(isOpen) {
    if (!isOpen) {
      stateController.clear();
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
      cityController.clear();
    }
  }
}
