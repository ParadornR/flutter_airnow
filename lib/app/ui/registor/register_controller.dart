import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/login/login_page.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // collection users
  final users = FirebaseFirestore.instance.collection('users');

  var fullNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var cfPasswordController = TextEditingController().obs;

  var formKey = GlobalKey<FormState>().obs;

  Future<void> register() async {
    if (passwordController.value.text == cfPasswordController.value.text) {
      if (formKey.value.currentState!.validate()) {
        try {
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(
                email: emailController.value.text.trim(),
                password: passwordController.value.text.trim(),
              );
          // ดึง UID ของผู้ใช้
          String uid = userCredential.user!.uid;
          log("User signUp UID: $uid");
          // collection users
          users.doc(uid).set({
            'name': fullNameController.value.text,
            'email': emailController.value.text,
            // 'profile_picture': urlController.text,
            'created_at': DateTime.now(),
          });
          Get.snackbar('Succeed', "สมัครสมาชิกสำเร็จ!");
          Get.off(LoginPage()); // กลับไปหน้าก่อนหน้า (Login)
        } catch (e) {
          Get.snackbar('Error', "เกิดข้อผิดพลาด: $e");
        }
      }
    } else {
      Get.snackbar(
        'Error',
        'The password and confirmation password do not match.',
      );
    }
  }
}
