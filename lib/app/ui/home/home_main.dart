import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/home_page.dart';
import 'package:flutter_airnow/app/ui/home/profile_page.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const [HomePage(), ProfilePage()];
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _widgetOptions,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            log("floatingActionButton: add()");
          },
          tooltip: 'Increment',
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _selectedIndex = 0;
                    log('Home');
                    setState(() {});
                    _pageController.animateToPage(
                      _selectedIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon:
                      _selectedIndex == 0
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.home),
                              ),
                              SizedBox(width: 4),
                              CustomText(
                                text: 'Home',
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          )
                          : Icon(Icons.home, color: Colors.white),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _selectedIndex = 1;
                    log('Profile');
                    setState(() {});
                    _pageController.animateToPage(
                      _selectedIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon:
                      _selectedIndex == 1
                          ? Row(
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
                          : Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
