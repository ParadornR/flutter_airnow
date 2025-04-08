import 'dart:developer';

import 'package:flutter_airnow/app/UI/login/login_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageController extends GetxController {
  Future<void> logOut() async {
    // clear data and jump to login Screen
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log('${prefs.getBool('isLogin')}');
    log('${prefs.getString('uid')}');
    await prefs.remove('isLogin');
    await prefs.remove('uid');
    log('isLogin:${prefs.getBool('isLogin')}');
    log('uid:${prefs.getString('uid')}');
    Get.offAll(() => LoginPage());
  }
}
