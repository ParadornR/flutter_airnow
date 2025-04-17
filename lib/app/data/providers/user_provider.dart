import 'dart:developer';
import 'package:flutter_airnow/app/data/models/user_model.dart';
import 'package:flutter_airnow/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends GetxController {
  var user = Rx<User?>(null);
  var userId = Rx<String?>(null);
  final UserRepository _userRepository = UserRepository();

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  // Function to fetch user data and update the state
  Future<void> fetchUserData() async {
    try {
      userId.value = (await _getUserIdFromSharedPreferences());
      log('[UserProvider] userId : $userId');
      if (userId.value != null) {
        user.value = await _userRepository.fetchUserData(userId.value!);
        log('[UserProvider] User ID: ${userId.value}');
        log('[UserProvider] Data ID: ${user.value}');
      } else {
        log('[UserProvider] User ID is not available');
      }
    } catch (e) {
      log('[UserProvider] Error in provider: $e');
    }
  }

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}
