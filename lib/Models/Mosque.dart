import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mosque {
  late LatLng latLng;
  late String name;
  late String placeId;
  late String descritption;
  double distance = 0;

  Mosque.mapToMosque(Map<String, dynamic> json) {
    name = json['name'].toString();
    descritption = json['vicinity'].toString();
    placeId = json['place_id'].toString();
    latLng = LatLng(json['geometry']["location"]['lat'],
        json['geometry']["location"]['lng']);
  }
}
