import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_page.dart';
import 'package:flutter_airnow/app/ui/loading/loading_controller.dart';
import 'package:flutter_airnow/app/ui/login/login_page.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({super.key});
  final LoadingController loadingController = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Obx(() {
          // ignore: unnecessary_null_comparison
          if (loadingController.hasInternet.value == false) {
            // ระหว่างรอการตรวจสอบสถานะล็อกอิน
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text("No Internet"),
                  ],
                ),
              ),
            );
          } else if (loadingController.isLogin.value == null) {
            // ระหว่างรอการตรวจสอบสถานะล็อกอิน
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (loadingController.isLogin.value == false) {
            // ถ้าไม่ได้ล็อกอิน
            return LoginPage();
          } else {
            // ถ้าล็อกอินแล้ว
            return HomePage();
          }
        }),
      ),
    );
  }
}
