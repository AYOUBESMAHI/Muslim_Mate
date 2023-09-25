class City {
  late double lng;
  late double lat;
  late String name;
  late String state;
  late String country;
  City.mapToCity(Map<String, dynamic> map) {
    try {
      lng = double.parse(map["lng"]);
      lat = double.parse(map["lat"]);
      name = map["city"];
      country = map["country"];
      state = map["admin_name"];
    } catch (err) {
      print('mapToCity Err ===> $err');
    }
  }
}
