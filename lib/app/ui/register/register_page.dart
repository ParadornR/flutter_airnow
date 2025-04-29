import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/register/register_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerController = Get.put(RegisterController());
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
              child: Form(
                key: registerController.formKey.value,
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
                                "assets/lottie/moonset.json",
                                width: MediaQuery.of(context).size.width * 0.55,
                                fit: BoxFit.cover,
                                decoder: LottieComposition.decodeGZip,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomText(
                              text: "Create Account",
                              size: 36,
                              weight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller:
                                registerController.fullNameController.value,
                            keyboardType: TextInputType.name,
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
                              prefixIcon: Icon(Icons.person),
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your full name.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller:
                                registerController.emailController.value,
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
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your full name.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller:
                                registerController.passwordController.value,
                            obscureText: true,
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
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return "Your password must be at least 8 characters.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller:
                                registerController.cfPasswordController.value,
                            obscureText: true,
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
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return "Your confirm password must be at least 8 characters.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  registerController.register();
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
                                        text: "Sign up",
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
                            text: "Already have a accont?",
                            size: 16,
                            weight: FontWeight.w200,
                          ),
                          TextButton(
                            onPressed: () {
                              log('Sign in');
                              Get.back();
                            },
                            child: CustomText(
                              text: "Sign in",
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
      ),
    );
  }
}
