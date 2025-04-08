import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_page.dart';
import 'package:flutter_airnow/app/ui/home/profile_page.dart';
import 'package:get/get.dart';

class HomeMainController extends GetxController {
  
  var selectedIndex = 0.obs;
  final List<Widget> widgetOptions = const [HomePage(), ProfilePage()];
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
