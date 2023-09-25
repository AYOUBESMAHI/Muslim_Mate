import 'package:flutter/material.dart';
import 'package:prayers_times/prayers_times.dart';

import '../Models/Prayer.dart';
import '../Utils/Helpers.dart';
import '../Services/SavingData_Service.dart';

class PrayersProvider extends ChangeNotifier {
  List<Prayer> prayers = [];

  void fetchWeekPrayers(Coordinates coordinates) async {
    prayers.clear();
    PrayerCalculationParameters params = PrayerCalculationMethod.morocco();
    params.madhab = PrayerMadhab.shafi;

    for (int i = 0; i < 7; i++) {
      PrayerTimes prayerTimes = PrayerTimes(
          coordinates: coordinates,
          calculationParameters: params,
          locationName: 'Africa/Casablanca',
          dateTime: DateTime.now().add(Duration(days: i)));

      for (int j = 0; j < 6; j++) {
        switch (j) {
          case 0:
            prayers
                .add(Prayer("Fajr", correctDate(prayerTimes.fajrStartTime!)));
            break;
          case 1:
            prayers.add(Prayer("Sunrise", correctDate(prayerTimes.sunrise!)));
            break;
          case 2:
            prayers
                .add(Prayer("Dohre", correctDate(prayerTimes.dhuhrStartTime!)));
            break;
          case 3:
            prayers.add(Prayer("Asre", correctDate(prayerTimes.asrStartTime!)));
            break;
          case 4:
            prayers.add(
                Prayer("Maghrib", correctDate(prayerTimes.maghribStartTime!)));
            break;
          case 5:
            prayers
                .add(Prayer("Isha", correctDate(prayerTimes.ishaStartTime!)));
            break;
        }
        if (prayers[prayers.length - 1].time.isBefore(DateTime.now())) {
          prayers.removeAt(prayers.length - 1);
        }
      }
    }
    await savePrayers(prayers);
    // await Workmanager().cancelAll();
    // Workmanager().registerOneOffTask(const Uuid().v4(), "notification",
    //     initialDelay: GetDuration(prayers[0].time, DateTime.now()),
    //     inputData: {'name': prayers[0].name});
  }
}
