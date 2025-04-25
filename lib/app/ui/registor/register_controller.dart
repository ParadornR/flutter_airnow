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
          Get.snackbar(
            'Registration Successful',
            "Your account has been created successfully. Welcome aboard!",
            margin: EdgeInsets.all(8),
            backgroundColor: Color.fromRGBO(76, 175, 80, 1),
            colorText: Colors.white,
          );
          Get.off(LoginPage());
        } catch (e) {
          Get.snackbar(
            'Duplicate Registration',
            "This account has already been registered. Please log in or use a different email address.",
            margin: EdgeInsets.all(8),
            backgroundColor: Color.fromRGBO(255, 193, 7, 1),
            colorText: Colors.white,
          );
        }
      }
    } else {
      Get.snackbar(
        'Password Mismatch',
        "The password and confirmation password do not match. Please try again.",
        margin: EdgeInsets.all(8),
        backgroundColor: Color.fromRGBO(244, 67, 54, 1),
        colorText: Colors.white,
      );
    }
  }
}
