import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/login/login_controller.dart';
import 'package:flutter_airnow/app/ui/register/register_page.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.95,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lottie/sunrise.json",
                              width: MediaQuery.of(context).size.width * 0.55,
                              fit: BoxFit.cover,
                              decoder: LottieComposition.decodeGZip,
                            ),
                          ],
                        ),
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
                            controller:
                                loginController.passwordController.value,
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
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                log("loginController.signInWithEmailAndPass()");
                                loginController.signInWithEmailAndPass();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: "Sign in",
                                      size: 18,
                                      color:
                                          Theme.of(
                                            context,
                                          ).appBarTheme.foregroundColor,
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward,
                                      color:
                                          Theme.of(
                                            context,
                                          ).appBarTheme.foregroundColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
        ),
      ),
    );
  }
}
