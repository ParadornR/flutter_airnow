import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3B78B3),
                  Color(0xFFA3E4FA),
                  Color(0xFFD1F8EF),
                  Colors.white,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
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
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
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
