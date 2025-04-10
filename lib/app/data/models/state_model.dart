class StateModel {
  Map<String, List<String>> data;

  StateModel({required this.data});

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    data: Map.from(json["data"]).map(
      (k, v) =>
          MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x))),
    ),
  );

  Map<String, dynamic> toJson() => {
    "data": Map.from(data).map(
      (k, v) =>
          MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x))),
    ),
  };
}

// class StateModel {
//   final Map<String, List<String>> data;

//   StateModel({required this.data});

//   factory StateModel.fromJson(Map<String, dynamic> json) {
//     return StateModel(
//       data: json.map((key, value) => MapEntry(key, List<String>.from(value))),
//     );
//   }

//   List<String> getStatesByCountry(String country) {
//     return data[country] ?? [];
//   }
// }
