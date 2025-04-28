import 'dart:developer';
import 'package:action_slider/action_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/city_data_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/country_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/geo_screen_controller.dart';
import 'package:flutter_airnow/app/ui/create/controller/state_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

class GeoScreen extends StatefulWidget {
  const GeoScreen({super.key});

  @override
  State<GeoScreen> createState() => _GeoScreenState();
}

class _GeoScreenState extends State<GeoScreen> {
  // find
  final userController = Get.find<UserController>();
  final countryController = Get.find<CountryController>();
  final stateController = Get.find<StateController>();
  final cityController = Get.find<CityController>();
  final cityDataController = Get.find<CityDataController>();
  final geoController = Get.find<GeoScreenController>();

  // put
  // final countryController = Get.put(CountryController());
  // final stateController = Get.put(StateController());
  // final cityController = Get.put(CityController());
  // final cityDataController = Get.put(CityDataController());

  // final geoController = Get.put(GeoScreenController());
  ActionSliderController? controller = ActionSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                    color:
                        geoController.selectedCountryValue.value == null
                            ? Colors.grey.shade300
                            : Colors.green.shade300,
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
                      onChanged:
                          (value) => geoController.onChangedCountry(value),
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
                    color:
                        geoController.selectedStateValue.value == null
                            ? Colors.grey.shade300
                            : Colors.green.shade300,
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
                if (cityDataController.isLoadingcityData.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:
                        geoController.selectedCityValue.value == null
                            ? Colors.grey.shade300
                            : Colors.green.shade300,
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
                          (isOpen) =>
                              geoController.onMenuStateChangeCity(isOpen),
                    ),
                  ),
                );
              }),
            ],
          ),
          Obx(
            () => Visibility(
              visible: geoController.isAllNotEmpty.value,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ActionSlider.standard(
                  sliderBehavior: SliderBehavior.stretch,
                  width: double.infinity,
                  backgroundColor: Theme.of(context).primaryColor,
                  toggleColor: Theme.of(context).appBarTheme.foregroundColor,
                  action: (controller) async {
                    controller.loading(); //starts loading animation
                    await geoController.loadAndSave();
                    log("canSave:${geoController.canSave.value}");
                    if (geoController.canSave.value) {
                      controller.success();
                      await Future.delayed(const Duration(seconds: 1));
                    } else {
                      controller.failure();
                      await Future.delayed(const Duration(seconds: 3));
                      controller.reset(); //resets the slider
                    }
                  },
                  child: CustomText(
                    text: 'Slide to Save Location',
                    size: 14,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
