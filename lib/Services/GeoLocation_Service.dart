import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> fetchCityName(double lat, double long) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    if (placemarks.isNotEmpty) {
      return placemarks.first.locality ?? "Not Found Name";
    }
    return "Not Found Name";
  } catch (err) {
    print("fetchCityName ===> $err");
    return "Not Found Name";
  }
}

Future<bool> checkServiceLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!serviceEnabled) {
        await Geolocator.getCurrentPosition();
        throw 'Location services are disabled.';
      }
      ;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return true;
  } catch (err) {
    await Geolocator.requestPermission();
    rethrow;
  }
}

Future<Position?> determinePosition() async {
  try {
    await checkServiceLocation();
    return await Geolocator.getCurrentPosition();
  } catch (err) {
    return null;
  }
}
