import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:flutter_airnow/app/ui/create/create_page.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_page_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageController = Get.put(HomePageController());
  final userProvider = Get.put(UserProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: homePageController.pageController.value,
        onPageChanged: (index) {
          homePageController.selectedIndex.value = index;
        },
        children: homePageController.widgetOptions,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log("floatingActionButton: add()");
          Get.to(() => CreatePage());
        },
        tooltip: 'Increment',
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => IconButton(
                onPressed: () {
                  homePageController.changePage(0);
                },
                icon:
                    homePageController.selectedIndex.value == 0
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
                        : Center(child: Icon(Icons.home, color: Colors.white)),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.3),
            Obx(
              () => IconButton(
                onPressed: () {
                  homePageController.changePage(1);
                },
                icon:
                    homePageController.selectedIndex.value == 1
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
    );
  }
}
