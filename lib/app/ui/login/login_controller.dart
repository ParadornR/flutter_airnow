import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  void signInWithEmailAndPass() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      String uid = userCredential.user!.uid;
      log("User signIn UID: $uid");

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', true);
      await prefs.setString('uid', uid);
      Get.snackbar(
        'Login successful!',
        "Welcome back.",
        margin: EdgeInsets.all(8),
        backgroundColor: Color.fromRGBO(76, 175, 80, 1),
        colorText: Colors.white,
      );
      Get.off(() => HomePage());
      onClose();
    } catch (e) {
      log("[Error]:$e");
      Get.snackbar(
        'Login failed',
        "Please check your username and password.",
        margin: EdgeInsets.all(8),
        backgroundColor: Color.fromRGBO(244, 67, 54, 1),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    // ทำการ clean up หรือเคลียร์ค่าที่ไม่จำเป็นเมื่อ controller หยุดทำงาน
    emailController.value.clear();
    passwordController.value.clear();
    super.onClose();
  }
}
