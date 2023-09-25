import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/Mosque.dart';
import '../Services/GoogleMapApi_Service.dart';
import '../Utils/Helpers.dart';

class MosquesProvider extends ChangeNotifier {
  List<Mosque> mosques = [];

  Future<void> fethNearMosques(LatLng position) async {
    mosques = [];
    try {
      final resp = await GoogleMapApiService.getNearbyMosques(position);
      for (var json in resp) {
        Mosque mosque = Mosque.mapToMosque(json);
        double distance = calculateDistance(
            position.latitude,
            position.longitude,
            mosque.latLng.latitude,
            mosque.latLng.longitude);
        mosque.distance = distance.abs();
        mosques.add(mosque);
      }
      mosques.sort((a, b) => a.distance.compareTo(b.distance));
      notifyListeners();
    } catch (err) {
      print("----> $err");
    }
  }
}
