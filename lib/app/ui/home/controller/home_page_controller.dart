import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/screen/home_screen.dart';
import 'package:flutter_airnow/app/ui/home/screen/profile_screen.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var selectedIndex = 0.obs;
  final List<Widget> widgetOptions = const [HomeScreen(), ProfileScreen()];
  var pageController = PageController().obs;

  void changePage(int index) {
    selectedIndex.value = index;
    log('Home');
    pageController.value.animateToPage(
      selectedIndex.value,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
