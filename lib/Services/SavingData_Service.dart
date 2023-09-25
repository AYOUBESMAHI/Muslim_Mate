import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Prayer.dart';

Future<void> savePrayers(List<Prayer> prayers) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final listPreyers = prayers.map((e) => e.prayerToMap()).toList();
  prefs.setStringList(
      "PrayersList", listPreyers.map((e) => json.encode(e)).toList());
}

Future<List<Prayer>> getPrayers() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("PrayersList")) {
    final prayersdata = prefs.getStringList("PrayersList")!;
    List<Prayer> prayers =
        prayersdata.map((e) => Prayer.mapToPrayer(json.decode(e))).toList();
    prayers.removeWhere((e) => e.time.isBefore(DateTime.now()));
    return prayers;
  }
  return [];
}

void initializePrayerNotification() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (!preferences.containsKey("Fajr")) {
    await preferences.setBool("Fajr", false);
    await preferences.setBool("Sunrise", false);
    await preferences.setBool("Dhuhr", false);
    await preferences.setBool("Asr", false);
    await preferences.setBool("Maghrib", false);
    await preferences.setBool("Isha", false);
  }
}

void updatePrayerNotification(String key, bool isActive) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setBool(key, isActive);
}

Future<bool> getPrayerNotification(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool(key) ?? false;
}
