//Fetch Data From json

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:muslim_mate/Models/Prayer.dart';
import 'package:muslim_mate/Services/LocalNotifiation_Service.dart';
import 'package:muslim_mate/Services/SavingData_Service.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

Future<List<dynamic>> fetchListFromJson(String path) async {
  try {
    String data = await rootBundle.loadString(path);
    return json.decode(data) as List<dynamic>;
  } catch (err) {
    print("Error fetch From Json => $err");
    return [];
  }
}

Future<Map<String, dynamic>> fetchMapFromJson(String path) async {
  try {
    String data = await rootBundle.loadString(path);
    return json.decode(data);
  } catch (err) {
    print("Error fetchMapFromJson  => $err");
    return {};
  }
}

bool areDatesEqual(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

DateTime dateAfter30minutes(DateTime date) {
  return DateTime(
          date.year, date.month, date.day, date.hour, date.minute, date.second)
      .add(const Duration(minutes: 30));
}

DateTime correctDate(DateTime date) {
  return DateTime(
      date.year, date.month, date.day, date.hour, date.minute, date.second);
}

String twoDegits(int n) => n.toString().padLeft(2, "0");

Duration GetDuration(DateTime date1, DateTime date2) {
  return Duration(
    hours: date1.hour - date2.hour,
    minutes: date1.minute - date2.minute,
    seconds: date1.second - date2.second,
  );
}

//Prayer Notification
@pragma('vm:entry-point')
void callBackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      if (taskName == "notificationss") {
        print("------------");

        Workmanager().registerOneOffTask(const Uuid().v4(), "notificationss",
            initialDelay: Duration(seconds: 10));
      }
      if (taskName == "notification") {
        bool isAtive = await getPrayerNotification(inputData!['name']);
        if (isAtive) {
          final FlutterLocalNotificationsPlugin
              flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          LocalNotification.initialize(flutterLocalNotificationsPlugin);

          LocalNotification.showTextNotification(
              title: "Al-${inputData['name']}",
              message: "It's time for Al-${inputData['name']}",
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
        }
        List<Prayer> prayersList = await getPrayers();
        prayersList.removeAt(0);
        await savePrayers(prayersList);
        Prayer nextPrayer = prayersList[0];
        await Workmanager().cancelAll();

        Workmanager().registerOneOffTask(const Uuid().v4(), "notification",
            initialDelay: GetDuration(nextPrayer.time, DateTime.now()),
            inputData: {'name': nextPrayer.name});
      }
      return Future.value(true);
    } catch (err) {
      print("Error ===> $err");
      return Future.value(false);
    }
  });
}

///Distance

double calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371; // Radius of the Earth in kilometers
  final dLat = (lat2 - lat1) * (pi / 180);
  final dLon = (lon2 - lon1) * (pi / 180);
  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * (pi / 180)) *
          cos(lat2 * (pi / 180)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final distance = R * c; // Distance in kilometers
  return distance;
}
