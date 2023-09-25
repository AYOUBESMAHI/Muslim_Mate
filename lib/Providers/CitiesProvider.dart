import 'package:flutter/material.dart';

import '../Models/City.dart';
import '../Utils/Helpers.dart';

class CitiesProvider extends ChangeNotifier {
  List<City> _cities = [];
  List<City> get cities => _cities;

  Future<void> setCities() async {
    if (_cities.isNotEmpty) {
      return Future.value(true);
    }
    final json = await fetchListFromJson("Assets/Data/ma.json");

    _cities = json.map((e) => City.mapToCity(e)).toList();
    notifyListeners();
  }
}
