import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/loading/loading_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';

class HomeScreenController extends GetxController {
  final userController = Get.find<UserController>();
  final loadingController = Get.find<LoadingController>();

  var selectedIndex = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    ever(userController.userId, (String? uid) {
      if (uid != null && uid.isNotEmpty) {
        userController
            .fetchAllCardLocationData(); // ดึงข้อมูลเมื่อ userId พร้อม
      }
    });

    if (userController.userId.value != null &&
        userController.userId.value!.isNotEmpty) {
      userController.fetchAllCardLocationData(); // กรณี userId มีค่ามาแล้ว
    }
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
    return lottieMap[name] ?? 'assets/lottie/overcast.json';
  }

  Color checkBgPM25(int value) {
    if (value >= 0 && value <= 25) {
      return Color.fromRGBO(173, 242, 200, 1);
    } else if (value <= 37) {
      return Color.fromRGBO(255, 249, 180, 1);
    } else if (value <= 50) {
      return Color.fromRGBO(255, 214, 165, 1);
    } else if (value <= 90) {
      return Color.fromRGBO(255, 173, 173, 1);
    } else if (value <= 150) {
      return Color.fromRGBO(221, 190, 255, 1);
    } else if (value > 150) {
      return Color.fromRGBO(190, 170, 255, 1);
    } else {
      return Colors.grey;
    }
  }
}
