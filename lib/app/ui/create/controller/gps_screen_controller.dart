import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/models/city_data_model.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_data_controller.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_screen_controller.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GpsScreenController extends GetxController {
  final cityDataController = Get.find<CityDataController>();
  final userController = Get.find<UserController>();
  final homeScreenController = Get.find<HomeScreenController>();

  var latitude = Rx<double?>(null);
  var longitude = Rx<double?>(null);

  var value = Rx<Data?>(null);
  var pollution = Rx<Pollution?>(null);
  var weather = Rx<Weather?>(null);

  late osm.MapController controller;

  @override
  void onInit() {
    super.onInit();
    canSave.value = false;
    showCurrentLocation();
    // loadData();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ตรวจสอบว่า location service เปิดอยู่ไหม
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // เช็คและขอ permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // ดึงตำแหน่งปัจจุบัน
    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void showCurrentLocation() async {
    log("[showCurrentLocation]: loading location . . .");
    try {
      Position position = await _getCurrentLocation();
      log('Location = [lat: ${position.latitude}, lon: ${position.longitude}]');

      controller = osm.MapController(
        initPosition: osm.GeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      log("[showCurrentLocation]: succeed");
    } catch (e) {
      log('$e');
    }
  }

  loadData() async {
    log("[loadData]: loading data . . .");
    await cityDataController.loadDataCityWithLocation(
      latitude: '${latitude.value}',
      longitude: '${longitude.value}',
    );

    value.value = cityDataController.cityData.value!.data;
    pollution.value = cityDataController.cityData.value!.data.current.pollution;
    weather.value = cityDataController.cityData.value!.data.current.weather;
    log("[loadData]: succeed");
  }

  var canSave = false.obs;
  saveData() async {
    await loadData();
    log("[saveData]: saving data . . .");
    final value = cityDataController.cityData.value!.data;
    final pollution = cityDataController.cityData.value!.data.current.pollution;
    final weather = cityDataController.cityData.value!.data.current.weather;
    try {
      final userId = userController.userId.value;
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
        Get.back(closeOverlays: true);
        Get.snackbar(
          'Location Data Saved',
          "Your location data has been successfully recorded.",
          margin: EdgeInsets.all(8),
          backgroundColor: Color.fromRGBO(76, 175, 80, 1),
          colorText: Colors.white,
        );
        log("[saveData]: succeed");
        await userController.fetchAllCardLocationData();
        // Get.back(closeOverlays: true);
        // Get.offAll(() => HomePage());
      } else {
        log('มีข้อมูล location นี้แล้ว');
        Get.snackbar(
          'Location Data Already Exists',
          "This location is already saved in the system.",
          margin: EdgeInsets.all(8),
          backgroundColor: Color.fromRGBO(255, 193, 7, 1),
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      log('เกิดข้อผิดพลาดในการบันทึกข้อมูล: $e\n$stackTrace');
    }
  }
}
