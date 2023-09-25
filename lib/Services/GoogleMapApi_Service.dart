import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapApiService {
  static final dio = Dio();

  static Future<List<dynamic>> getNearbyMosques(LatLng latLng) async {
    try {
      final response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?',
          queryParameters: {
            'keyword': 'mosque|مسجد',
            'location': '${latLng.latitude},${latLng.longitude}',
            'radius': '2200',
            'key': FlutterConfig.get('api_key')
          });
      print("frfrfr ====> $response");
      return response.data["results"];
    } catch (err) {
      print('getNearbyMosques ====> $err');
      return [];
    }
  }
}
