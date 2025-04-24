import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_screen_controller.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:get/get.dart';

class DatailController extends GetxController {
  final userController = Get.find<UserController>();
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  void onClose() {
    userController.fetchUserData();
    userController.fetchAllCardLocationData();
    super.onClose();
  }

  delete() {
    int selectedIndex = homeScreenController.selectedIndex.value!;
    final item = userController.dataList[selectedIndex];
    final location = item['location']['city'];
    userController.deleteCardDataUser(location);
  }

  String checkStringPM25(int value) {
    if (value >= 0 && value <= 25) {
      return "Good";
    } else if (value <= 37) {
      return "Moderate";
    } else if (value <= 50) {
      return "Unhealthy for sensitive groups";
    } else if (value <= 90) {
      return "Unhealthy";
    } else if (value <= 150) {
      return "Very unhealthy";
    } else if (value > 150) {
      return "Hazardous";
    } else {
      return "unknown";
    }
  }

  String checkStringPM10(int value) {
    if (value >= 0 && value <= 50) {
      return "Good";
    } else if (value <= 80) {
      return "Moderate";
    } else if (value <= 120) {
      return "Unhealthy for sensitive groups";
    } else if (value <= 180) {
      return "Unhealthy";
    } else if (value <= 300) {
      return "Very unhealthy";
    } else if (value > 300) {
      return "Hazardous";
    } else {
      return "unknown";
    }
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

  Color checkBgPM10(int value) {
    if (value >= 0 && value <= 50) {
      return Color.fromRGBO(173, 242, 200, 1); // เขียวมิ้นต์อ่อน
    } else if (value <= 80) {
      return Color.fromRGBO(255, 249, 180, 1); // เหลืองอ่อน
    } else if (value <= 120) {
      return Color.fromRGBO(255, 214, 165, 1); // ส้มพีชอ่อน
    } else if (value <= 180) {
      return Color.fromRGBO(255, 173, 173, 1); // ชมพูแดงอ่อน
    } else if (value <= 300) {
      return Color.fromRGBO(221, 190, 255, 1); // ม่วงอ่อน
    } else if (value > 300) {
      return Color.fromRGBO(190, 170, 255, 1); // ม่วงเข้มกว่า
    } else {
      return Colors.grey;
    }
  }
}
