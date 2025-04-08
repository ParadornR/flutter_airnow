import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_page.dart';
import 'package:flutter_airnow/app/ui/home/profile_page.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeMainController extends GetxController {
  var selectedIndex = 0.obs;
  final List<Widget> widgetOptions = const [HomePage(), ProfilePage()];
  var pageController = PageController().obs;
}
