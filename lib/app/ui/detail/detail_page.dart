import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/widget/custom_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isEdited = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          actions: [
            isEdited
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      isEdited = !isEdited;
                      setState(() {});
                    },
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      isEdited = !isEdited;
                      setState(() {});
                    },
                  ),
                ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA3E4FA),
                      Color(0xFFD1F8EF),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomText(
                        text: "Weather",
                        size: 36,
                        weight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "32°C",
                          size: 40,
                          weight: FontWeight.bold,
                        ),
                        Icon(Icons.cloud, size: 72, color: Colors.blue),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Bangkok",
                          size: 24,
                          weight: FontWeight.bold,
                        ),

                        CustomText(
                          text: "Partly Cloudy",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Pressure",
                              size: 24,
                              weight: FontWeight.w300,
                            ),
                            CustomText(
                              text: "1013 hPa",
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: "Wind",
                              size: 24,
                              weight: FontWeight.w300,
                            ),
                            CustomText(
                              text: "1,93 m/s",
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Humidity",
                              size: 24,
                              weight: FontWeight.w300,
                            ),
                            CustomText(
                              text: "37 %",
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: "Direction",
                              size: 24,
                              weight: FontWeight.w300,
                            ),
                            CustomText(
                              text: "65° ",
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color(0xFFA3E4FA),
                  //     Color(0xFFD1F8EF),
                  //     Colors.white,
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: "Air Quality",
                      size: 36,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          text: "US AQI",
                          size: 24,
                          weight: FontWeight.normal,
                        ),
                        CustomText(
                          text: "137",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "US AQI",
                          size: 24,
                          weight: FontWeight.normal,
                        ),
                        CustomText(
                          text: "69",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
