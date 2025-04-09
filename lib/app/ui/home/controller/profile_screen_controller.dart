import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_airnow/app/UI/login/login_page.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenController extends GetxController {
  Future<void> logOut() async {
    // clear data and jump to login Screen
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log('${prefs.getBool('isLogin')}');
    log('${prefs.getString('uid')}');
    await prefs.remove('isLogin');
    await prefs.remove('uid');
    log('isLogin:${prefs.getBool('isLogin')}');
    log('uid:${prefs.getString('uid')}');

    await FirebaseAuth.instance.signOut();
    Get.delete<UserProvider>();
    Get.delete<HomePageController>();
    Get.offAll(() => LoginPage());
  }
}
