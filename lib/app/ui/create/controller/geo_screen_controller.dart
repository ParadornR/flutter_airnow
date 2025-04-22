import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_data_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/state_controller.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class GeoScreenController extends GetxController {
  // find
  final stateController = Get.find<StateController>();
  final cityController = Get.find<CityController>();
  final cityDataController = Get.find<CityDataController>();
  final userProvider = Get.find<UserProvider>();
  final homeScreenController = Get.find<HomeScreenController>();

  var selectedCountryValue = Rx<String?>(null);
  var selectedStateValue = Rx<String?>(null);
  var selectedCityValue = Rx<String?>(null);

  final countryTextEditing = TextEditingController();
  final stateTextEditing = TextEditingController();
  final cityTextEditing = TextEditingController();

  onChangedCountry(value) {
    selectedStateValue.value = null;
    selectedCityValue.value = null;
    isAllNotEmpty.value = false;
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
    isAllNotEmpty.value = false;
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
    isAllNotEmpty.value =
        selectedCountryValue.value!.isNotEmpty &&
        selectedStateValue.value!.isNotEmpty &&
        selectedCityValue.value!.isNotEmpty;
  }

  onMenuStateChangeCity(isOpen) {
    if (!isOpen) {
      cityTextEditing.clear();
    }
  }

  var canSave = false.obs;
  var isAllNotEmpty = false.obs;
  loadAndSave() async {
    //use load data from api
    canSave.value = true;
    isAllNotEmpty.value =
        selectedCountryValue.value!.isNotEmpty &&
        selectedStateValue.value!.isNotEmpty &&
        selectedCityValue.value!.isNotEmpty;

    if (isAllNotEmpty.value) {
      await cityDataController.loadDataCityWithCSC(
        country: selectedCountryValue.value!,
        state: selectedStateValue.value!,
        city: selectedCityValue.value!,
      );

      //load data location
      final value = cityDataController.cityData.value!.data;
      final pollution =
          cityDataController.cityData.value!.data.current.pollution;
      final weather = cityDataController.cityData.value!.data.current.weather;

      try {
        final userId = userProvider.userId.value;
        final locationRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('location');

        // 1. บันทึกข้อมูล location
        final cityDocRef = locationRef.doc(value.city);
        // หา location ใน data ที่ซ้ำ
        final cityDocQuery =
            await locationRef.where('city', isEqualTo: value.city).get();
        // Locatio ที่หาได้มีไหม?
        if (cityDocQuery.docs.isEmpty) {
          // ไม่มี สร้างใหม่
          
          await cityDocRef.set({
            'city': value.city,
            'state': value.state,
            'country': value.country,
            'location': value.location.coordinates,
            'last_update_at': DateTime.now(),
          });

          final pollutionRef = cityDocRef.collection('pollution');
          log("[pollution.ts]:${pollution.ts}");
          await pollutionRef.add({
            'aqicn': pollution.aqicn,
            'aqius': pollution.aqius,
            'maincn': pollution.maincn,
            'mainus': pollution.mainus,
            'ts': pollution.ts,
            'created_at': DateTime.now(),
          });
          final weatherRef = cityDocRef.collection('weather');
          log("[weather.ts]:${weather.ts}");
          await weatherRef.add({
            'hu': weather.hu,
            'ic': weather.ic,
            'pr': weather.pr,
            'tp': weather.tp,
            'wd': weather.wd,
            'ws': weather.ws,
            'ts': weather.ts,
            'created_at': DateTime.now(),
          });
          await homeScreenController.fetchUserData();
         
        } else {
          log('มีข้อมูล location นี้แล้ว');
          canSave.value = false;
        }
      } catch (e, stackTrace) {
        log('เกิดข้อผิดพลาดในการบันทึกข้อมูล: $e\n$stackTrace');
        canSave.value = false;
      }
    }
  }
}
