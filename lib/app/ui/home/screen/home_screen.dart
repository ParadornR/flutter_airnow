import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/widget/custom_text.dart';
import 'package:flutter_airnow/app/ui/detail/detail_page.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_screen_controller.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text_marquee.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.put(HomeScreenController());
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("AirNow"), centerTitle: true),
          body: Obx(() => bodyWidget()),
        ),
      ),
    );
  }

  Widget bodyWidget() {
    if (userController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    } else if (userController.dataList.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => userController.updateData(),
        child: Center(
          child: ListView(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                child: Center(
                  child: Column(
                    children: [
                      CustomText(
                        text: "NOTING!!",
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "Your collection list is empty.",
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => userController.updateData(),
      child: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: userController.dataList.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = userController.dataList[index];
          final location = item['location'];
          final weather = item['weather'];
          final pollution = item['pollution'];

          final cityName = location['city'];
          final stateName = location['state'];
          final countryName = location['country'];

          final temperature = "${weather['tp'] ?? 'N/A'}°c";
          final humidity = "${weather['hu'] ?? 'N/A'}%";
          final condition = weather['ic'] ?? "Unknown";
          // final aqi = "${pollution['aqius'] ?? 'N/A'}";
          int aqi = pollution['aqius'];
          return InkWell(
            onTap: () {
              homeScreenController.selectedIndex.value = index;
              Get.to(() => DetailPage());
            },
            child: buildLocationCard(
              city: cityName,
              state: stateName,
              country: countryName,
              temperature: temperature,
              humidity: humidity,
              condition: condition,
              aqi: aqi,
            ),
          );
        },
      ),
    );
  }

  Widget buildLocationCard({
    required String city,
    required String state,
    required String country,
    required String temperature,
    required String humidity,
    required String condition,
    required int aqi,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        border: Border.all(),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWithOverflowCheck(
                              text: city,
                              size: 28,
                              weight: FontWeight.bold,
                            ),
                            Row(
                              children: [
                                CustomText(text: '$state,', size: 14),
                                CustomText(text: country, size: 14),
                              ],
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(
                                  text: temperature,
                                  size: 32,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(width: 8),
                                CustomText(
                                  text: humidity,
                                  size: 14,
                                  weight: FontWeight.bold,
                                ),
                                CustomText(text: " Humidity", size: 14),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Lottie.asset(
                              homeScreenController.getWeatherLottie(condition),
                              fit: BoxFit.cover,
                              decoder: LottieComposition.decodeGZip,
                            ),
                            TextWithOverflowCheck(
                              text: homeScreenController.getWeatherDescription(
                                condition,
                              ),
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: homeScreenController.checkBgPM25(aqi),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "PM", size: 14, weight: FontWeight.bold),
                  CustomText(text: "2.5", size: 14, weight: FontWeight.bold),
                  SizedBox(height: 8),
                  CustomText(text: "$aqi", size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
