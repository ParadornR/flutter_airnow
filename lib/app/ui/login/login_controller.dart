import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_airnow/app/ui/home/home_main.dart';

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
      Get.off(() => HomeMain());
      onClose();
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
