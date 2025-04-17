import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingController extends GetxController {
  var isLogin = false.obs;

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<void> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log('[SharedPreferences]isLogin: ${prefs.getBool('isLogin')}');
    log('[SharedPreferences]uid: ${prefs.getString('uid')}');
    isLogin.value = prefs.getBool('isLogin') ?? false;
  }
}
