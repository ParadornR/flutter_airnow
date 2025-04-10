// repositories/state_repository.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_airnow/app/data/models/state_model.dart';

class StateRepository {
  Future<StateModel> loadStatesFromAssets() async {
    final String response = await rootBundle.loadString(
      'assets/data/countries_with_states.json',
    );
    final data = json.decode(response);
    return StateModel.fromJson(data);
  }

  Future<StateModel> loadCountryOnly(String countryName) async {
    final StateModel fullData = await loadStatesFromAssets();
    final filteredData = {
      if (fullData.data.containsKey(countryName))
        countryName: fullData.data[countryName]!,
    };
    return StateModel(data: filteredData);
  }
}
