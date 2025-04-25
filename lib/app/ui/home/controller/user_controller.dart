import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/models/city_data_model.dart';
import 'package:flutter_airnow/app/data/models/user_model.dart';
import 'package:flutter_airnow/app/data/providers/city_data_provider.dart';
import 'package:flutter_airnow/app/data/repositories/city_data_repository.dart';
import 'package:flutter_airnow/app/ui/home/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var user = Rx<User?>(null);
  var userId = Rx<String?>(null);
  var isLoading = true.obs;
  var dataList = <Map<String, dynamic>>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    cityDataRepository = CityDataRepository(apiService: CityDataApiService());
    fetchUserData();
    super.onInit();
  }

  // Function to fetch user data and update the state
  Future<void> fetchUserData() async {
    try {
      userId.value = await _getUserIdFromSharedPreferences();
      log('[fetchUserData] userId : ${userId.value}');
      if (userId.value != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('users').doc(userId.value!).get();
        if (snapshot.exists) {
          user.value = User.fromMap(snapshot.data() as Map<String, dynamic>);
          log('[fetchUserData] Data: ${user.value}');
          fetchAllCardLocationData();
        } else {
          log('[fetchUserData] No user found');
        }
      } else {
        log('[fetchUserData] User ID is not available');
      }
    } catch (e) {
      log('[fetchUserData] Error: $e');
    }
  }

  Future<void> deleteCardDataUser(String city) async {
    try {
      // เรียกดู userId จาก SharedPreferences
      userId.value = (await _getUserIdFromSharedPreferences());
      log('[deleteCardDataUser] userId : $userId');

      if (userId.value != null) {
        // ลบเอกสารทั้งหมดในคอลเล็กชัน 'weather'
        final weatherDocs =
            await firestore
                .collection('users')
                .doc(userId.value!)
                .collection('location')
                .doc(city)
                .collection('weather')
                .get();

        for (var doc in weatherDocs.docs) {
          await doc.reference.delete();
        }

        // ลบเอกสารทั้งหมดในคอลเล็กชัน 'pollution'
        final pollutionDocs =
            await firestore
                .collection('users')
                .doc(userId.value!)
                .collection('location')
                .doc(city)
                .collection('pollution')
                .get();

        for (var doc in pollutionDocs.docs) {
          await doc.reference.delete();
        }

        // หลังจากลบเอกสารในคอลเล็กชัน 'weather' และ 'pollution' แล้ว ลบเอกสาร 'Bang Kapi'
        await firestore
            .collection('users')
            .doc(userId.value!)
            .collection('location')
            .doc(city)
            .delete();
        Get.snackbar(
          'Success',
          "The item has been successfully deleted.",
          margin: EdgeInsets.all(8),
          backgroundColor: Color.fromRGBO(76, 175, 80, 1),
          colorText: Colors.white,
        );
        // กลับไปที่หน้าก่อน
        Get.offAll(() => HomePage());
        log(
          'Successfully deleted weather, pollution documents and the city document.',
        );
      } else {
        log('[deleteCardDataUser] CardData is not available');
      }
    } catch (e) {
      log('[deleteCardDataUser] Error in provider: $e');
    }
  }

  Future<void> fetchAllCardLocationData() async {
    isLoading.value = true;
    try {
      if (userId.value != null && userId.value!.isNotEmpty) {
        final data = await _getUserAllCardLocation(userId.value!);
        dataList.assignAll(data);
      }
    } catch (e) {
      log('[fetchAllLocationData] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> _getUserAllCardLocation(
    String userId,
  ) async {
    final locationSnapshot =
        await firestore
            .collection('users')
            .doc(userId)
            .collection('location')
            .get();

    List<Map<String, dynamic>> fullData = [];
    for (final doc in locationSnapshot.docs) {
      final locationData = doc.data();
      final city = locationData['city'];

      final weatherFuture =
          firestore
              .collection('users')
              .doc(userId)
              .collection('location')
              .doc(city)
              .collection('weather')
              .get();

      final pollutionFuture =
          firestore
              .collection('users')
              .doc(userId)
              .collection('location')
              .doc(city)
              .collection('pollution')
              .get();

      final results = await Future.wait([weatherFuture, pollutionFuture]);

      final weather =
          results[0].docs.isNotEmpty ? results[0].docs.last.data() : {};
      final pollution =
          results[1].docs.isNotEmpty ? results[1].docs.last.data() : {};

      fullData.add({
        'location': locationData,
        'weather': weather,
        'pollution': pollution,
      });
    }
    log("[fullData]: $fullData");
    return fullData;
  }

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  late CityDataRepository cityDataRepository;
  var cityData = Rx<CityDataModel?>(null);

  updateData() async {
    final length = dataList.length;
    log("[dataList]: $dataList");
    log("[length]: $length");
    for (var index = 0; index <= length; index++) {
      final city = dataList[index]['location']['city'];
      final state = dataList[index]['location']['state'];
      final country = dataList[index]['location']['country'];
      await loadDataCityWithCSC(city: city, state: state, country: country);
      await loadAndUpdate();
    }
    await fetchAllCardLocationData();
  }

  Future<void> loadDataCityWithCSC({
    required String city,
    required String state,
    required String country,
  }) async {
    log('[loadDataCityWithCSC]: loading...');
    log('[CSC][city]: $city, [state]: $state, [country]: $country');
    try {
      final result = await cityDataRepository.fetchDataWithCSC(
        city,
        state,
        country,
      );
      cityData.value = result;
      log('[loadDataCityWithCSC]: succeed');
      log('[cityData.value]: ${cityData.value!.data.city}');
      // log('[cityData.value]: ${cityData.value}');
    } catch (e) {
      log("[loadDataCityWithCSC][Error]$e");
    }
  }

  loadAndUpdate() async {
    final value = cityData.value!.data;
    final pollution = cityData.value!.data.current.pollution;
    final weather = cityData.value!.data.current.weather;

    try {
      final locationRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId.value)
          .collection('location');
      final cityDocRef = locationRef.doc(value.city);

      // 2. ตรวจสอบการซ้ำใน pollutionRef
      final pollutionRef = cityDocRef.collection('pollution');
      final pollutionQuery =
          await pollutionRef
              .where(
                'ts',
                isEqualTo: pollution.ts,
              ) // ตรวจสอบว่า timestamp ซ้ำไหม
              .get();

      if (pollutionQuery.docs.isEmpty) {
        // ไม่มีข้อมูล pollution นี้ ซ้ำกันแล้ว
        log("[pollution.ts]: ${pollution.ts}");
        await pollutionRef.add({
          'aqicn': pollution.aqicn,
          'aqius': pollution.aqius,
          'maincn': pollution.maincn,
          'mainus': pollution.mainus,
          'ts': pollution.ts,
          'created_at': DateTime.now(),
        });
        log("[pollution.ts][${value.city}]:✔️ ดึงและบันทึกข้อมูลเสร็จแล้ว");
      } else {
        log(
          "[loadAndUpdate][${value.city}]: ❌ This pollution data is repeated.",
        );
      }

      // 3. ตรวจสอบการซ้ำใน weatherRef
      final weatherRef = cityDocRef.collection('weather');
      final weatherQuery =
          await weatherRef
              .where('ts', isEqualTo: weather.ts) // ตรวจสอบว่า timestamp ซ้ำไหม
              .get();

      if (weatherQuery.docs.isEmpty) {
        // ไม่มีข้อมูล weather นี้ ซ้ำกันแล้ว
        log("[weather.ts]: ${weather.ts}");
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
        log("[weather.ts][${value.city}]:✔️ ดึงและบันทึกข้อมูลเสร็จแล้ว");
      } else {
        log(
          "[loadAndUpdate][${value.city}]: ❌ This weather information is duplicated.",
        );
      }
    } catch (e, stackTrace) {
      log('[loadAndUpdate]Error: $e\n$stackTrace');
    }
  }
}
