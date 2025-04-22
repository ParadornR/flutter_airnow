import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/UI/widget/custom_text.dart';
import 'package:flutter_airnow/app/ui/create/controller/gps_controller.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  final gpsController = Get.put(GpsController());
  bool havelocation = false;

  final controller = MapController.withPosition(
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      gpsController.showCurrentLocation();
                      gpsController.loadData();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.near_me,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            text: "Current Location",
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  gpsController.latitude.value != null
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("latitude"),
                              Text("longitude"),
                              Text("Country"),
                              Text("State"),
                              Text("City"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("${gpsController.latitude.value ?? ''}"),
                              Text("${gpsController.longitude.value ?? ''}"),
                              Text(gpsController.value.value?.country ?? ''),
                              Text(gpsController.value.value?.state ?? ''),
                              Text(gpsController.value.value?.city ?? ''),
                            ],
                          ),
                        ],
                      )
                      : SizedBox(),

                  ElevatedButton(
                    onPressed: () async {
                      gpsController.saveData();
                    },
                    child: Text("Save data"),
                  ),
                  // ActionSlider.standard(
                  //   sliderBehavior: SliderBehavior.stretch,
                  //   width: double.infinity,
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   toggleColor: Theme.of(context).appBarTheme.foregroundColor,
                  //   action: (controller) async {
                  //     controller.loading(); //starts loading animation
                  //     await Future.delayed(const Duration(seconds: 1));
                  //     // geoController.loadAndSave();
                  //     log("canSave:${gpsController.canSave.value}");
                  //     if (gpsController.canSave.value == false) {
                  //       controller.failure();
                  //       await Future.delayed(const Duration(seconds: 3));
                  //     } else {
                  //       controller.success();
                  //       await Future.delayed(const Duration(seconds: 1));
                  //       Get.back();
                  //     }
                  //     controller.reset(); //resets the slider
                  //   },
                  //   child: CustomText(
                  //     text: 'Slide to Save Location',
                  //     size: 14,
                  //     color: Theme.of(context).appBarTheme.foregroundColor,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
