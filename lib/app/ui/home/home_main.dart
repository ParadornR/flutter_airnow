import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_main_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final homeMainController = Get.put(HomeMainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: homeMainController.pageController.value,
          onPageChanged: (index) {
            homeMainController.selectedIndex.value = index;
          },
          children: homeMainController.widgetOptions,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            log("floatingActionButton: add()");
          },
          tooltip: 'Increment',
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => IconButton(
                  onPressed: () {
                    homeMainController.changePage(0);
                  },
                  icon:
                      homeMainController.selectedIndex.value == 0
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.home),
                              ),
                              SizedBox(width: 4),
                              CustomText(
                                text: "Home",
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          )
                          : Center(
                            child: Icon(Icons.home, color: Colors.white),
                          ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.3),
              Obx(
                () => IconButton(
                  onPressed: () {
                    homeMainController.changePage(1);
                  },
                  icon:
                      homeMainController.selectedIndex.value == 1
                          ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Profile',
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person),
                              ),
                            ],
                          )
                          : Center(
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
