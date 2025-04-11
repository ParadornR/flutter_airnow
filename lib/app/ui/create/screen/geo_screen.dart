import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/providers/city_data_provider.dart';
import 'package:flutter_airnow/app/data/providers/city_provider.dart';
import 'package:flutter_airnow/app/data/providers/country_provider.dart';
import 'package:flutter_airnow/app/data/providers/state_provider.dart';
import 'package:flutter_airnow/app/ui/create/controller/geo_controller.dart';
import 'package:get/get.dart';

class GeoScreen extends StatefulWidget {
  const GeoScreen({super.key});

  @override
  State<GeoScreen> createState() => _GeoScreenState();
}

class _GeoScreenState extends State<GeoScreen> {
  final stateProviser = Get.put(StateProvider());
  final cityProvider = Get.put(CityProvider());
  final cityDataProvider = Get.put(CityDataProvider());
  final geoController = Get.put(GeoController());
  final countryProvider = Get.put(CountryProvider());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (countryProvider.isLoading.value) {
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
                        countryProvider.countries
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
                      searchController: geoController.countryController,
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
                          controller: geoController.countryController,
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
              if (stateProviser.isLoading.value) {
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
                        stateProviser.states
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
                      searchController: geoController.stateController,
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
                          controller: geoController.stateController,
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
              if (stateProviser.isLoading.value) {
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
                        cityProvider.city.value?.data
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
                      searchController: geoController.stateController,
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
                          controller: geoController.stateController,
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
            ElevatedButton(
              onPressed: () {
                if (geoController.selectedCountryValue.value!.isNotEmpty &&
                    geoController.selectedStateValue.value!.isNotEmpty &&
                    geoController.selectedCityValue.value!.isNotEmpty) {
                  cityDataProvider.loadCityData(
                    country: geoController.selectedCountryValue.value!,
                    state: geoController.selectedStateValue.value!,
                    city: geoController.selectedCityValue.value!,
                  );
                }
              },
              child: Text("Serch"),
            ),
            ElevatedButton(
              onPressed: () {
                final value = cityDataProvider.cityData.value!.data;
                final pollution =
                    cityDataProvider.cityData.value!.data.current.pollution;
                final weather =
                    cityDataProvider.cityData.value!.data.current.weather;
                log("city: ${value.city}");
                log("state: ${value.state}");
                log("country: ${value.country}");
                log("coordinates: ${value.location.coordinates}");
                log("pollution ts: ${pollution.ts}");
                log("aqicn: ${pollution.aqicn}");
                log("maincn: ${pollution.maincn}");
                log("aqius: ${pollution.aqius}");
                log("mainus: ${pollution.mainus}");
                log("weather ts: ${weather.ts}");
                log("weather tp: ${weather.tp}");
                log("weather pr: ${weather.pr}");
                log("weather hu: ${weather.hu}");
                log("weather ws: ${weather.ws}");
                log("weather wd: ${weather.wd}");
                log("weather ic: ${weather.ic}");
              },
              child: Text("test"),
            ),
          ],
        ),
      ),
    );
  }
}
