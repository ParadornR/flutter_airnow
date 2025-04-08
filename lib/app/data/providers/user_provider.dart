import 'dart:developer';

import 'package:flutter_airnow/app/data/models/user_model.dart';
import 'package:flutter_airnow/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends GetxController {
  var user = Rx<User?>(null); // Observable user data

  final UserRepository _userRepository = UserRepository();

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  // Function to fetch user data and update the state
  Future<void> fetchUserData() async {
    try {
      String? userId = await _getUserIdFromSharedPreferences();
      log('userId : $userId');
      if (userId != null) {
        user.value = await _userRepository.fetchUserData(userId);
        log('User ID : $userId');
        log('Data ID : ${user.value}');
      } else {
        log('User ID is not available');
      }
    } catch (e) {
      log('Error in provider: $e');
    }
  }

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}
