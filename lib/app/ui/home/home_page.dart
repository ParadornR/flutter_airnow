import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:flutter_airnow/app/ui/create/create_page.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageController = Get.put(HomePageController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        bottomNavigationBar: Obx(() {
          return StylishBottomBar(
            backgroundColor: Theme.of(context).primaryColor,
            notchStyle: NotchStyle.circle,
            option: DotBarOptions(dotStyle: DotStyle.circle),
            items: [
              BottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
              ),
              BottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ],
            hasNotch: true,
            currentIndex: homePageController.selectedIndex.value,
            onTap: (index) {
              setState(() {
                homePageController.selectedIndex.value = index;
                homePageController.pageController.value.jumpToPage(index);
              });
            },

            // fabLocation: StylishBarFabLocation.end,
          );
        }),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Obx(
      //         () => IconButton(
      //           onPressed: () {
      //             homePageController.changePage(0);
      //           },
      //           icon:
      //               homePageController.selectedIndex.value == 0
      //                   ? Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       CircleAvatar(
      //                         backgroundColor: Colors.white,
      //                         child: Icon(Icons.home),
      //                       ),
      //                       SizedBox(width: 4),
      //                       CustomText(
      //                         text: "Home",
      //                         size: 14,
      //                         color: Colors.white,
      //                       ),
      //                     ],
      //                   )
      //                   : Center(
      //                     child: Icon(Icons.home, color: Colors.white),
      //                   ),
      //         ),
      //       ),
      //       SizedBox(width: MediaQuery.of(context).size.width * 0.3),
      //       Obx(
      //         () => IconButton(
      //           onPressed: () {
      //             homePageController.changePage(1);
      //           },
      //           icon:
      //               homePageController.selectedIndex.value == 1
      //                   ? Row(
      //                     mainAxisSize: MainAxisSize.min,
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       CustomText(
      //                         text: 'Profile',
      //                         size: 14,
      //                         color: Colors.white,
      //                       ),
      //                       SizedBox(width: 4),
      //                       CircleAvatar(
      //                         backgroundColor: Colors.white,
      //                         child: Icon(Icons.person),
      //                       ),
      //                     ],
      //                   )
      //                   : Center(
      //                     child: Icon(Icons.person, color: Colors.white),
      //                   ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
