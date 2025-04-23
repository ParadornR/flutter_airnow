import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/widget/custom_text.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_screen_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text_marquee.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final homeScreenController = Get.find<HomeScreenController>();
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
          centerTitle: true,
          // actions: [
          //   isEdited
          //       ? Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: IconButton(
          //           icon: Icon(Icons.check),
          //           onPressed: () {
          //             isEdited = !isEdited;
          //             setState(() {});
          //           },
          //         ),
          //       )
          //       : Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: IconButton(
          //           icon: Icon(Icons.edit),
          //           onPressed: () {
          //             isEdited = !isEdited;
          //             setState(() {});
          //           },
          //         ),
          //       ),
          // ],
        ),
        body: Obx(() {
          if (homeScreenController.userId.value.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          int selectedIndex = homeScreenController.selectedIndex.value!;
          final item = homeScreenController.dataList[selectedIndex];

          final location = item['location'];
          final weather = item['weather'];

          final pollution = item['pollution'];

          final cityName = location['city'];
          final stateName = location['state'];
          final countryName = location['country'];

          final temperature = "${weather['tp'] ?? 'N/A'}°c";
          final condition = weather['ic'] ?? "Unknown";

          final humidity = "${weather['hu'] ?? 'N/A'}";
          final pressure = "${weather['pr'] ?? 'N/A'}";
          final wind = "${weather['ws'] ?? 'N/A'}";
          final direction = "${weather['wd'] ?? 'N/A'}";

          final pm25 = "${pollution['aqius'] ?? 'N/A'}";
          final pm10 = "${pollution['aqicn'] ?? 'N/A'}";

          int valuePm25 = pollution['aqius'];
          int valuePm10 = pollution['aqicn'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Row(
                                textBaseline: TextBaseline.alphabetic,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  CustomText(
                                    text: temperature,
                                    size:
                                        MediaQuery.of(context).size.width *
                                        0.15,
                                    color:
                                        Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Lottie.asset(
                              homeScreenController.getWeatherLottie(condition),
                              fit: BoxFit.cover,
                              decoder: LottieComposition.decodeGZip,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          CustomText(
                            text: "Temperature",
                            size: 16,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          SizedBox(),
                          CustomText(
                            text: homeScreenController.getWeatherDescription(
                              condition,
                            ),
                            size: 14,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          SizedBox(),
                        ],
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: CustomText(
                          text: cityName,
                          size: 24,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: stateName,
                            size: 16,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          CustomText(
                            text: ",",
                            size: 16,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          CustomText(
                            text: countryName,
                            size: 16,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(209, 233, 252, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Pressure",
                              size: 16,
                              color: Color.fromRGBO(33, 37, 41, 1),
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(
                                  text: pressure,
                                  size: 24,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                                CustomText(
                                  text: " hPa",
                                  size: 16,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(209, 233, 252, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Humidity",
                              size: 16,
                              color: Color.fromRGBO(33, 37, 41, 1),
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(
                                  text: humidity,
                                  size: 24,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                                CustomText(
                                  text: " %",
                                  size: 16,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(209, 233, 252, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Wind",
                              size: 16,
                              color: Color.fromRGBO(33, 37, 41, 1),
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(
                                  text: wind,
                                  size: 24,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                                CustomText(
                                  text: " m/s",
                                  size: 16,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(209, 233, 252, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Direction",
                              size: 16,
                              color: Color.fromRGBO(33, 37, 41, 1),
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(
                                  text: direction,
                                  size: 24,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                                CustomText(
                                  text: "°",
                                  size: 24,
                                  color: Color.fromRGBO(33, 37, 41, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: checkBgPM25(valuePm25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [CustomText(text: "PM2.5", size: 16)],
                            ),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(text: pm25, size: 24),
                                CustomText(text: " µg/m³", size: 16),
                              ],
                            ),
                            TextWithOverflowCheck(
                              text: checkStringPM25(valuePm25),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: checkBgPM10(valuePm10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "PM10", size: 16),
                            Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                CustomText(text: pm10, size: 24),
                                CustomText(text: " µg/m³", size: 16),
                              ],
                            ),
                            TextWithOverflowCheck(
                              text: checkStringPM10(110),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Wrap(
                //   direction: Axis.horizontal,
                //   alignment: WrapAlignment.center,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(173, 242, 200, 1),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: CustomText(text: "Good", size: 14),
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(255, 249, 180, 1),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: CustomText(text: "Moderate", size: 14),
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(255, 214, 165, 1),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: CustomText(
                //         text: "Unhealthy for sensitive groups",
                //         size: 14,
                //       ),
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(255, 173, 173, 1),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: CustomText(text: "Unhealthy", size: 14),
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(221, 190, 255, 1),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: CustomText(text: "Very unhea,lthy", size: 14),
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Color.fromRGBO(190, 170, 255, 1),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: CustomText(text: "Hazardous", size: 14),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String checkStringPM25(int value) {
    if (value >= 0 && value <= 25) {
      return "Good";
    } else if (value <= 37) {
      return "Moderate";
    } else if (value <= 50) {
      return "Unhealthy for sensitive groups";
    } else if (value <= 90) {
      return "Unhealthy";
    } else if (value <= 150) {
      return "Very unhealthy";
    } else if (value > 150) {
      return "Hazardous";
    } else {
      return "unknown";
    }
  }

  String checkStringPM10(int value) {
    if (value >= 0 && value <= 50) {
      return "Good";
    } else if (value <= 80) {
      return "Moderate";
    } else if (value <= 120) {
      return "Unhealthy for sensitive groups";
    } else if (value <= 180) {
      return "Unhealthy";
    } else if (value <= 300) {
      return "Very unhealthy";
    } else if (value > 300) {
      return "Hazardous";
    } else {
      return "unknown";
    }
  }

  Color checkBgPM25(int value) {
    if (value >= 0 && value <= 25) {
      return Color.fromRGBO(173, 242, 200, 1);
    } else if (value <= 37) {
      return Color.fromRGBO(255, 249, 180, 1);
    } else if (value <= 50) {
      return Color.fromRGBO(255, 214, 165, 1);
    } else if (value <= 90) {
      return Color.fromRGBO(255, 173, 173, 1);
    } else if (value <= 150) {
      return Color.fromRGBO(221, 190, 255, 1);
    } else if (value > 150) {
      return Color.fromRGBO(190, 170, 255, 1);
    } else {
      return Colors.grey;
    }
  }

  Color checkBgPM10(int value) {
    if (value >= 0 && value <= 50) {
      return Color.fromRGBO(173, 242, 200, 1); // เขียวมิ้นต์อ่อน
    } else if (value <= 80) {
      return Color.fromRGBO(255, 249, 180, 1); // เหลืองอ่อน
    } else if (value <= 120) {
      return Color.fromRGBO(255, 214, 165, 1); // ส้มพีชอ่อน
    } else if (value <= 180) {
      return Color.fromRGBO(255, 173, 173, 1); // ชมพูแดงอ่อน
    } else if (value <= 300) {
      return Color.fromRGBO(221, 190, 255, 1); // ม่วงอ่อน
    } else if (value > 300) {
      return Color.fromRGBO(190, 170, 255, 1); // ม่วงเข้มกว่า
    } else {
      return Colors.grey;
    }
  }
}
