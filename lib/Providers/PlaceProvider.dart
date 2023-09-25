import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Services/GeoLocation_Service.dart';
import '../Models/Place.dart';

class PlaceProvider extends ChangeNotifier {
  Place? _currentplace;
  Place? get currentPlace => _currentplace;

  void fetchCurrentLocation() async {
    try {
      await checkServiceLocation();
      Position? position = await determinePosition();
      String nameCity =
          await fetchCityName(position!.latitude, position.longitude);
      if (_currentplace != null && _currentplace!.city == nameCity) {
        return;
      }
      _currentplace = Place(position.longitude, position.latitude, nameCity);
      notifyListeners();
    } catch (err) {
      print('fetchCurrentLocation Error ==> $err');
    }
  }
}
