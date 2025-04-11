import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/registor/register_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

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
          body: Form(
            key: registerController.formKey.value,
            child: Column(
              children: [
                Spacer(),
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
                  controller: registerController.fullNameController.value,
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
                  controller: registerController.emailController.value,
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
                  controller: registerController.passwordController.value,
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
                      return "Please enter your password.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: registerController.cfPasswordController.value,
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
                      return "Please enter your confirm password.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        registerController.register();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("SIGN UP"),
                          SizedBox(width: 8),
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
    );
  }
}
