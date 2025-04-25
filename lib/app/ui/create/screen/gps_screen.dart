import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/create/controller/gps_screen_controller.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  final gpsController = Get.find<GpsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (gpsController.latitude.value != null ||
                  gpsController.longitude.value != null) ...[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    width: MediaQuery.of(context).size.width,
                    child: OSMFlutter(
                      controller: gpsController.controller,
                      mapIsLoading: Scaffold(
                        body: Center(
                          child: Lottie.asset(
                            "assets/lottie/loader.json",
                            width: MediaQuery.of(context).size.width * 0.55,
                            fit: BoxFit.cover,
                            decoder: LottieComposition.decodeGZip,
                          ),
                        ),
                      ),
                      onMapIsReady: (p0) {
                        log('$p0');
                        gpsController.canSave.value = p0;
                      },
                      osmOption: OSMOption(
                        userTrackingOption: UserTrackingOption(
                          enableTracking: true,
                          unFollowUser: false,
                        ),
                        zoomOption: ZoomOption(
                          initZoom: 17,
                          minZoomLevel: 3,
                          maxZoomLevel: 19,
                          stepZoom: 1.0,
                        ),
                        userLocationMarker: UserLocationMaker(
                          personMarker: MarkerIcon(
                            icon: Icon(
                              Icons.place,
                              color: const Color.fromARGB(255, 255, 0, 0),
                              size: 100,
                            ),
                          ),
                          directionArrowMarker: MarkerIcon(
                            icon: Icon(Icons.double_arrow, size: 48),
                          ),
                        ),
                        roadConfiguration: RoadOption(roadColor: Colors.white),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Center(
                  child: Lottie.asset(
                    "assets/lottie/loader.json",
                    width: MediaQuery.of(context).size.width * 0.55,
                    fit: BoxFit.cover,
                    decoder: LottieComposition.decodeGZip,
                  ),
                ),
              ],
            ],
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (gpsController.canSave.value) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              gpsController.saveData();
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add_location_alt,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          );
        }
        return SizedBox();
      }),
    );
  }
}
