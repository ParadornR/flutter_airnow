import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:flutter_airnow/app/ui/home/controller/profile_screen_controller.dart';
import 'package:flutter_airnow/app/ui/profile/myprofile_page.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _HomePageState();
}

class _HomePageState extends State<ProfileScreen> {
  final profileScreenController = Get.put(ProfileScreenController());
  final userProvider = Get.find<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Profile"), centerTitle: true),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Obx(
                  () => CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    child:
                        userProvider.user.value!.urlImage.isEmpty
                            ? Icon(Icons.person, size: 48)
                            : CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.14,
                              backgroundImage: NetworkImage(
                                userProvider.user.value!.urlImage,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () =>
                      CustomText(text: userProvider.user.value!.name, size: 18),
                ),
                Obx(
                  () => CustomText(
                    text: userProvider.user.value!.email,
                    size: 16,
                    weight: FontWeight.w300,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    log("My Profile");
                    Get.to(() => MyprofilePage());
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
                    log("Settings");
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
                    profileScreenController.logOut();
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
