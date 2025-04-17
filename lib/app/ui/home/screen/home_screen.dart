import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/widget/custom_text.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userProvider = Get.find<UserProvider>();

  Future<List<Map<String, dynamic>>> getAllUserLocationWithDetails(
    String userId,
  ) async {
    final locationSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('location')
            .get();

    final locationDocs = locationSnapshot.docs;

    List<Map<String, dynamic>> fullData = [];

    for (final doc in locationDocs) {
      final locationData = doc.data();
      final city = locationData['city'];

      final weatherFuture =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('location')
              .doc(city)
              .collection('weather')
              .get();

      final pollutionFuture =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('location')
              .doc(city)
              .collection('pollution')
              .get();

      final results = await Future.wait([weatherFuture, pollutionFuture]);

      final weather =
          results[0].docs.isNotEmpty ? results[0].docs.first.data() : {};
      final pollution =
          results[1].docs.isNotEmpty ? results[1].docs.first.data() : {};

      fullData.add({
        'location': locationData,
        'weather': weather,
        'pollution': pollution,
      });
    }
    log("[fullData]:$fullData");
    return fullData;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userId = userProvider.userId.value;
      if (userId == null || userId.isEmpty) {
        return Scaffold(
          appBar: AppBar(title: Text("AirNow")),
          body: Column(
            children: [
              Text("กำลังโหลดข้อมูลผู้ใช้..."),
              CircularProgressIndicator(),
            ],
          ),
        );
      }
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("AirNow"), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllUserLocationWithDetails(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('ไม่มีข้อมูล'));
                }
                final allData = snapshot.data!;
                return ListView.separated(
                  itemCount: allData.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final location = allData[index]['location'];
                    final weather = allData[index]['weather'];
                    final pollution = allData[index]['pollution'];

                    final cityName = location['city'];
                    final stateName = location['state'];
                    final countryName = location['country'];

                    final temperature = "${weather['tp'] ?? 'N/A'}°c";
                    final humidity = "${weather['hu'] ?? 'N/A'}%";
                    final condition = weather['ic'] ?? "Unknown";
                    final aqi = "${pollution['aqius'] ?? 'N/A'}";
                    return buildLocationCard(
                      city: cityName,
                      state: stateName,
                      country: countryName,
                      temperature: temperature,
                      humidity: humidity,
                      condition: condition,
                      aqi: aqi,
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    });
  }

  String getWeatherDescription(String name) {
    const weatherMap = {
      '01d': 'clear sky ', //(day) 1.
      '01n': 'clear sky ', //(night)
      '02d': 'few clouds ', //(day)
      '02n': 'few clouds ', //(night)
      '03d': 'scattered clouds',
      '04d': 'broken clouds',
      '09d': 'shower rain',
      '10d': 'rain ', //(day time)
      '10n': 'rain ', //(night time)
      '11d': 'thunderstorm',
      '13d': 'snow',
      '50d': 'mist', //12.
    };

    return weatherMap[name] ?? 'unknown';
  }

  Widget buildLocationCard({
    required String city,
    required String state,
    required String country,
    required String temperature,
    required String humidity,
    required String condition,
    required String aqi,
  }) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      CustomText(text: city, size: 28, weight: FontWeight.bold),
                      Spacer(),
                      CustomText(text: '$state,', size: 14),
                      CustomText(text: country, size: 14),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: temperature,
                              size: 32,
                              weight: FontWeight.w500,
                            ),
                            Row(
                              children: [
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud, size: 36, color: Colors.blue),
                            Text(
                              getWeatherDescription(condition),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.orange.shade100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: "US", size: 14, weight: FontWeight.bold),
                CustomText(text: "AQI", size: 14, weight: FontWeight.bold),
                SizedBox(height: 8),
                CustomText(text: aqi, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
