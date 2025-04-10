import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
                        (isOpen) => geoController.onMenuStateChangeCity(isOpen),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
