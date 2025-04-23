import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';

class HomeScreenController extends GetxController {
  final userProvider = Get.find<UserProvider>();
  var isLoading = true.obs;
  var userId = ''.obs;
  var dataList = <Map<String, dynamic>>[].obs;
  var selectedIndex = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    // listen เมื่อ userProvider.userId มีค่า แล้วค่อยเซ็ต
    ever(userProvider.userId, (String? uid) {
      if (uid != null && uid.isNotEmpty) {
        userId.value = uid;
        fetchUserData();
      }
    });
    // เผื่อ userId มีค่ามาแล้วตั้งแต่แรก
    if (userProvider.userId.value != null &&
        userProvider.userId.value!.isNotEmpty) {
      userId.value = userProvider.userId.value!;
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final data = await getAllUserLocationWithDetails(userId.value);
      dataList.assignAll(data);
    } catch (e) {
      log('เกิดข้อผิดพลาด: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUserLocationWithDetails(
    String userId,
  ) async {
    final locationSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('location')
            .get();

    List<Map<String, dynamic>> fullData = [];

    for (final doc in locationSnapshot.docs) {
      final locationData = doc.data();
      final city = locationData['city'];

      final weatherFuture =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('location')
              .doc(city)
              .collection('weather')
              .get();

      final pollutionFuture =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('location')
              .doc(city)
              .collection('pollution')
              .get();

      final results = await Future.wait([weatherFuture, pollutionFuture]);

      final weather =
          results[0].docs.isNotEmpty ? results[0].docs.first.data() : {};
      final pollution =
          results[1].docs.isNotEmpty ? results[1].docs.first.data() : {};

      fullData.add({
        'location': locationData,
        'weather': weather,
        'pollution': pollution,
      });
    }
    // log("[fullData]:$fullData");
    return fullData;
  }

  String getWeatherDescription(String name) {
    const weatherMap = {
      '01d': 'Clear Sky', //(day)
      '01n': 'Clear Sky', //(night)
      '02d': 'Few Clouds', //(day)
      '02n': 'Few Clouds', //(night)
      '03d': 'Scattered Clouds',
      '04d': 'Broken Clouds',
      '09d': 'Shower Rain',
      '10d': 'Rain', //(day time)
      '10n': 'Rain', //(night time)
      '11d': 'Thunderstorm',
      '13d': 'Snow',
      '50d': 'Mist',
    };
    return weatherMap[name] ?? 'unknown';
  }

  String getWeatherLottie(String name) {
    const lottieMap = {
      '01d': 'assets/lottie/clear-day.json', //(day)
      '01n': 'assets/lottie/clear-night.json', //(night)
      '02d': 'assets/lottie/fog-day.json', //(day)
      '02n': 'assets/lottie/fog-night.json', //(night)
      '03d': 'assets/lottie/dust.json',
      '04d': 'assets/lottie/overcast.json',
      '09d': 'assets/lottie/overcast-drizzle.json',
      '10d': 'assets/lottie/overcast-day-rain.json', //(day time)
      '10n': 'assets/lottie/overcast-night-rain.json', //(night time)
      '11d': 'assets/lottie/thunderstorms-overcast-rain.json',
      '13d': 'assets/lottie/overcast-snow.json',
      '50d': 'assets/lottie/overcast-fog.json',
    };
    return lottieMap[name] ?? 'assets/lottie/thunderstorms-overcast-rain.json';
  }
  

}
