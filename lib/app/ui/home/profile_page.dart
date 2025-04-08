import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/loading/loading_page.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _HomePageState();
}

class _HomePageState extends State<ProfilePage> {
  Future<void> logOut() async {
    // clear data and jump to login Screen
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log('${prefs.getBool('isLogin')}');
    log('${prefs.getString('uid')}');
    await prefs.remove('isLogin');
    await prefs.remove('uid');
    log('isLogin:${prefs.getBool('isLogin')}');
    log('uid:${prefs.getString('uid')}');
    Get.off(() => LoadingPage());

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => LoadingPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Profile"), centerTitle: true),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                CircleAvatar(radius: 48, child: Icon(Icons.person, size: 32)),
                SizedBox(height: 8),
                CustomText(text: 'Full Name', size: 18),
                CustomText(
                  text: 'Test@gmail.com',
                  size: 16,
                  weight: FontWeight.w300,
                  color: Colors.grey.shade500,
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    log("My Profile");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 16),
                            CustomText(text: "My Profile", size: 16),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2),
                InkWell(
                  onTap: () {
                    log("Log out");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 16),
                            CustomText(text: "Settings", size: 16),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2),
                InkWell(
                  onTap: () {
                    log("Log out");
                    logOut();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 16),
                            CustomText(text: "Log out", size: 16),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
