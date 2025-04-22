import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/registor/register_page.dart';
import 'package:flutter_airnow/app/ui/login/login_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Login",
                        size: 36,
                        weight: FontWeight.w700,
                      ),
                      CustomText(
                        text: "Please sign in to continue.",
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextField(
                    controller: loginController.emailController.value,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                    buildCounter: (
                      context, {
                      required currentLength,
                      required maxLength,
                      required isFocused,
                    }) {
                      return SizedBox.shrink(); // ไม่แสดงตัวเลข
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'EMAIL',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => TextField(
                    controller: loginController.passwordController.value,
                    obscureText: true,
                    maxLength: 64,
                    buildCounter: (
                      context, {
                      required currentLength,
                      required maxLength,
                      required isFocused,
                    }) {
                      return SizedBox.shrink(); // ไม่แสดงตัวเลข
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'PASSWORD',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: "Login",
                        size: 14,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        log("loginController.signInWithEmailAndPass()");
                        loginController.signInWithEmailAndPass();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Login"),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don't have an account?",
                      size: 16,
                      weight: FontWeight.w200,
                    ),
                    TextButton(
                      onPressed: () {
                        log('Sign up');
                        loginController.onClose();
                        Get.to(() => RegisterPage());
                      },
                      child: CustomText(
                        text: "Sign up",
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
