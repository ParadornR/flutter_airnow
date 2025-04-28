import 'dart:developer';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingController extends GetxController {
  var isLogin = false.obs;
  var hasInternet = false.obs;
  @override
  void onInit() {
    checkInternet();
    checkLogin();
    super.onInit();
  }

  Future<void> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log('[SharedPreferences]isLogin: ${prefs.getBool('isLogin')}');
    log('[SharedPreferences]uid: ${prefs.getString('uid')}');
    isLogin.value = prefs.getBool('isLogin') ?? false;
  }

  Future<void> checkInternet() async {
    bool result = await InternetConnection().hasInternetAccess;
    hasInternet.value = result;
  }
}
