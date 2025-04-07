import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don’t have an account?",
                      size: 16,
                      weight: FontWeight.w200,
                    ),
                    TextButton(
                      onPressed: () {
                        log('Sign up');
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
