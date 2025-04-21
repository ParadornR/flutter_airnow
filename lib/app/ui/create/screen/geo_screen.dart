import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_data_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/country_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/geo_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/state_controller.dart';
import 'package:get/get.dart';

class GeoScreen extends StatefulWidget {
  const GeoScreen({super.key});

  @override
  State<GeoScreen> createState() => _GeoScreenState();
}

class _GeoScreenState extends State<GeoScreen> {
  // find
  final userProvider = Get.find<UserProvider>();
  // put
  final countryController = Get.put(CountryController());
  final stateController = Get.put(StateController());
  final cityController = Get.put(CityController());
  final cityDataController = Get.put(CityDataController());

  final geoController = Get.put(GeoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (countryController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Country',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items:
                        countryController.countries
                            .map(
                              (item) => DropdownMenuItem(
                                value: item.country,
                                child: Text(
                                  item.country,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    value: geoController.selectedCountryValue.value,
                    onChanged: (value) => geoController.onChangedCountry(value),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 200,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    menuItemStyleData: const MenuItemStyleData(height: 40),
                    dropdownSearchData: DropdownSearchData(
                      searchController: geoController.countryTextEditing,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: geoController.countryTextEditing,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for Country',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().toLowerCase().contains(
                          searchValue.toLowerCase(),
                        );
                      },
                    ),
                    onMenuStateChange:
                        (isOpen) =>
                            geoController.onMenuStateChangeCountry(isOpen),
                  ),
                ),
              );
            }),
            Obx(() {
              if (stateController.isLoadingState.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select State',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items:
                        stateController.states
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    value: geoController.selectedStateValue.value,
                    onChanged: (value) => geoController.onChangedState(value),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 200,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    menuItemStyleData: const MenuItemStyleData(height: 40),
                    dropdownSearchData: DropdownSearchData(
                      searchController: geoController.stateTextEditing,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: geoController.stateTextEditing,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for Country',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().toLowerCase().contains(
                          searchValue.toLowerCase(),
                        );
                      },
                    ),
                    onMenuStateChange:
                        (isOpen) =>
                            geoController.onMenuStateChangeState(isOpen),
                  ),
                ),
              );
            }),
            Obx(() {
              if (cityController.isLoadingCity.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select City',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items:
                        cityController.city.value?.data
                            .map(
                              (item) => DropdownMenuItem(
                                value: item.city,
                                child: Text(
                                  item.city,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    value: geoController.selectedCityValue.value,
                    onChanged: (value) => geoController.onChangedCity(value),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 200,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    menuItemStyleData: const MenuItemStyleData(height: 40),
                    dropdownSearchData: DropdownSearchData(
                      searchController: geoController.stateTextEditing,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: geoController.stateTextEditing,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for City',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().toLowerCase().contains(
                          searchValue.toLowerCase(),
                        );
                      },
                    ),
                    onMenuStateChange:
                        (isOpen) => geoController.onMenuStateChangeCity(isOpen),
                  ),
                ),
              );
            }),
            //use load data from api
            ElevatedButton(
              onPressed: () {
                if (geoController.selectedCountryValue.value!.isNotEmpty &&
                    geoController.selectedStateValue.value!.isNotEmpty &&
                    geoController.selectedCityValue.value!.isNotEmpty) {
                  cityDataController.loadDataCityWithCSC(
                    country: geoController.selectedCountryValue.value!,
                    state: geoController.selectedStateValue.value!,
                    city: geoController.selectedCityValue.value!,
                  );
                }
              },
              child: Text("Serch"),
            ),
            //use show data
            ElevatedButton(
              onPressed: () {
                final value = cityDataController.cityData.value!.data;
                final pollution =
                    cityDataController.cityData.value!.data.current.pollution;
                final weather =
                    cityDataController.cityData.value!.data.current.weather;
                log("city: ${value.city}");
                log("state: ${value.state}");
                log("country: ${value.country}");
                log("coordinates: ${value.location.coordinates}");
                log("pollution ts: ${pollution.ts}");
                log("pollution aqicn: ${pollution.aqicn}");
                log("pollution maincn: ${pollution.maincn}");
                log("pollution aqius: ${pollution.aqius}");
                log("pollution mainus: ${pollution.mainus}");
                log("weather ts: ${weather.ts}");
                log("weather tp: ${weather.tp}");
                log("weather pr: ${weather.pr}");
                log("weather hu: ${weather.hu}");
                log("weather ws: ${weather.ws}");
                log("weather wd: ${weather.wd}");
                log("weather ic: ${weather.ic}");
              },
              child: Text("Test"),
            ),
            //use update
            ElevatedButton(
              onPressed: () async {
                final value = cityDataController.cityData.value!.data;
                final pollution =
                    cityDataController.cityData.value!.data.current.pollution;
                final weather =
                    cityDataController.cityData.value!.data.current.weather;
                try {
                  final userId = userProvider.userId.value;
                  final locationRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('location');

                  // 1. บันทึกข้อมูล location
                  final cityDocRef = locationRef.doc(value.city);
                  await cityDocRef.set({
                    'city': value.city,
                    'state': value.state,
                    'country': value.country,
                    'location': value.location.coordinates,
                    'last_update_at': DateTime.now(),
                  });

                  final pollutionRef = cityDocRef.collection('pollution');
                  final pollutionQuery =
                      await pollutionRef
                          .where('ts', isEqualTo: pollution.ts)
                          .get();
                  log("[pollution.ts]:${pollution.ts}");
                  if (pollutionQuery.docs.isEmpty) {
                    await pollutionRef.add({
                      'aqicn': pollution.aqicn,
                      'aqius': pollution.aqius,
                      'maincn': pollution.maincn,
                      'mainus': pollution.mainus,
                      'ts': pollution.ts,
                      'created_at': DateTime.now(),
                    });
                  } else {
                    log('ข้อมูล pollution ซ้ำอยู่แล้ว ไม่เพิ่มใหม่');
                  }

                  final weatherRef = cityDocRef.collection('weather');
                  final weatherQuery =
                      await weatherRef.where('ts', isEqualTo: weather.ts).get();
                  log("[weather.ts]:${weather.ts}");
                  if (weatherQuery.docs.isEmpty) {
                    await weatherRef.add({
                      'hu': weather.hu,
                      'ic': weather.ic,
                      'pr': weather.pr,
                      'tp': weather.tp,
                      'wd': weather.wd,
                      'ws': weather.ws,
                      'ts': weather.ts,
                      'created_at': DateTime.now(),
                    });
                  } else {
                    log('ข้อมูล weather ซ้ำอยู่แล้ว ไม่เพิ่มใหม่');
                  }
                } catch (e, stackTrace) {
                  log('เกิดข้อผิดพลาดในการบันทึกข้อมูล: $e\n$stackTrace');
                }
              },
              child: Text("add"),
            ),
          ],
        ),
      ),
    );
  }
}
