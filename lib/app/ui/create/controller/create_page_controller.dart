import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_data_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/country_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/geo_screen_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/gps_screen_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/state_controller.dart';
import 'package:get/get.dart';

class CreatePageController extends GetxController {
  final userController = Get.find<UserController>();
  // put
  final countryController = Get.put(CountryController());
  final stateController = Get.put(StateController());
  final cityController = Get.put(CityController());
  final cityDataController = Get.put(CityDataController());

  final geoController = Get.put(GeoScreenController());
  final gpsController = Get.put(GpsScreenController());
}
