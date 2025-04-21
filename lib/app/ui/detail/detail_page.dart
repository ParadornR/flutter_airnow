
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/widget/custom_text.dart';
import 'package:flutter_airnow/app/ui/home/controller/home_screen_controller.dart';
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

          final humidity = "${weather['hu'] ?? 'N/A'} %";
          final pressure = "${weather['pr'] ?? 'N/A'} hPa";
          final wind = "${weather['ws'] ?? 'N/A'} m/s";
          final direction = "${weather['wd'] ?? 'N/A'}°";

          final pm25 = "${pollution['aqius'] ?? 'N/A'} µg/m³";
          final pm10 = "${pollution['aqicn'] ?? 'N/A'} µg/m³";
          int valuePM25 = pollution['aqius'];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
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
                                  homeScreenController.getWeatherLottie(
                                    condition,
                                  ),
                                  fit: BoxFit.cover,
                                  decoder: LottieComposition.decodeGZip,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(),
                                CustomText(
                                  text: "Temperature",
                                  size: 16,
                                  color:
                                      Theme.of(
                                        context,
                                      ).appBarTheme.foregroundColor,
                                ),
                                Center(child: SizedBox()),
                                CustomText(
                                  text: homeScreenController
                                      .getWeatherDescription(condition),
                                  size: 14,
                                  color:
                                      Theme.of(
                                        context,
                                      ).appBarTheme.foregroundColor,
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
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
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        CustomText(
                          text: ",",
                          size: 16,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        CustomText(
                          text: countryName,
                          size: 16,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                      ],
                    ),
                  ],
                ),

                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8),
                //           child: CustomText(
                //             text: "Stete, Country",
                //             size: 18,
                //             color: Colors.transparent,
                //           ),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(8.0),
                //           width: MediaQuery.of(context).size.width * 0.4,
                //           decoration: BoxDecoration(
                //             color: Theme.of(context).appBarTheme.foregroundColor,
                //             borderRadius: BorderRadius.only(
                //               topRight: Radius.circular(32),
                //               bottomRight: Radius.circular(32),
                //             ),
                //           ),
                //           child: Center(
                //             child: CustomText(text: "City", size: 24),
                //           ),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 16),
                //           child: CustomText(
                //             text: "Stete, Country",
                //             size: 18,
                //             color: Theme.of(context).appBarTheme.foregroundColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Pressure",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        CustomText(text: pressure, size: 24),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Humidity",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        CustomText(text: humidity, size: 24),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Wind",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        CustomText(text: wind, size: 24),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Direction",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        CustomText(text: direction, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 40,
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: "Pollution",
                              size: 24,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "PM 2.5",
                                  size: 24,
                                  color:
                                      Theme.of(
                                        context,
                                      ).appBarTheme.foregroundColor,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: checkPM25(valuePM25),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: CustomText(
                                    text: pm25,
                                    size: 18,
                                    color:
                                        Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "PM 10",
                                  size: 24,
                                  color:
                                      Theme.of(
                                        context,
                                      ).appBarTheme.foregroundColor,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: CustomText(
                                    text: pm10,
                                    size: 18,
                                    color:
                                        Theme.of(
                                          context,
                                        ).appBarTheme.foregroundColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(text: "Good", size: 14),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(text: "Moderate", size: 14),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(
                              text: "Unhealthy for sensitive groups",
                              size: 14,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(
                              text: "Unhealthy",
                              size: 14,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(
                              text: "Very unhea,lthy",
                              size: 14,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(
                              text: "Hazardous",
                              size: 14,
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  MaterialColor checkPM25(int value) {
    if (value <= 25) {
      return Colors.green;
    } else if (value <= 37) {
      return Colors.yellow;
    } else if (value <= 50) {
      return Colors.orange;
    } else if (value <= 90) {
      return Colors.red;
    } else if (value <= 150) {
      return Colors.deepPurple;
    } else {
      return Colors.purple;
    }
  }

  MaterialColor checkPM10(double value) {
    if (value <= 50) {
      return Colors.green;
    } else if (value <= 80) {
      return Colors.yellow;
    } else if (value <= 120) {
      return Colors.orange;
    } else if (value <= 180) {
      return Colors.red;
    } else if (value <= 300) {
      return Colors.deepPurple;
    } else {
      return Colors.purple;
    }
  }
}
