import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:provider/provider.dart';

//Providers
import '../Providers/PrayersProvider.dart';
import '../Providers/PlaceProvider.dart';
//Models
import '../Models/Place.dart';
//Utils
import '../Utils/Constants.dart';
import '../Utils/Helpers.dart';
//Widgets
import '../Widgets/SinglePrayTimeTile.dart';
import '../Widgets/DatePickerWidget.dart';
import '../Widgets/LocationWidget.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late PlaceProvider placeprovider;
  late PrayerTimes prayerTimes;
  Place? currentPlace;
  String placeName = "Casablanca";
  DateTime date = DateTime.now();
  Coordinates coordinates = Coordinates(33.5731, -7.5898);
  String currentImage = sunriseImag;
  Duration endPrayer = const Duration();
  String currentPrayer = "";
  String timerPray = "";
  late Timer timer;
  @override
  void initState() {
    super.initState();
    setPrayerTime(DateTime.now());
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    placeprovider = Provider.of<PlaceProvider>(context);
    changeCityLocation();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

//Update City
  void changeCity(String name, Coordinates newcoordinates) {
    placeName = name;
    coordinates = newcoordinates;
    setPrayerTime(DateTime.now());
  }

  void changeCityLocation() {
    placeprovider.fetchCurrentLocation();
    currentPlace = placeprovider.currentPlace;
    if (currentPlace != null) {
      changeCity(currentPlace!.city,
          Coordinates(currentPlace!.latitude, currentPlace!.longitude));
      Provider.of<PrayersProvider>(context, listen: false).fetchWeekPrayers(
        Coordinates(currentPlace!.latitude, currentPlace!.longitude),
      );
    }
  }

//Update Prayer Time
  void setPrayerTime(DateTime datetime) {
    date = datetime;
    PrayerCalculationParameters params = PrayerCalculationMethod.morocco();
    params.madhab = PrayerMadhab.shafi;

    prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      precision: true,
      locationName: 'Africa/Casablanca',
      dateTime: date,
    );

    if (areDatesEqual(datetime, DateTime.now())) {
      String prayer = updatePrayer(prayerTimes.currentPrayer());
      updateImage(prayer);
      updateTimer(prayer);
    } else {
      currentPrayer = "";
      timerPray = "";
    }
    setState(() {});
  }

//Set Timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTimer());
  }

  void addTimer() {
    final inseconds = endPrayer.inSeconds - 1;
    setState(() {
      if (inseconds < 0) {
        updateTimer(prayerTimes.nextPrayer());
      } else {
        endPrayer = Duration(seconds: inseconds);
      }
    });
  }

  void updateTimer(String prayer) {
    //timerPray = updatePrayer(prayer);
    // print(currentPrayer);
    if (prayer == 'fajrafter') {
      timerPray = updatePrayer(prayer);
    } else {
      timerPray = prayer;
    }
    if (prayerTimes.timeForPrayer(timerPray) == null) {
      return;
    }

    DateTime? dateTime = prayerTimes.timeForPrayer(timerPray)!;
    if (dateTime.hour < DateTime.now().hour) {
      endPrayer = Duration(
        days: 1,
        hours: dateTime.hour - DateTime.now().hour,
        minutes: dateTime.minute - DateTime.now().minute,
        seconds: dateTime.second - DateTime.now().second,
      );
    } else {
      endPrayer = Duration(
        hours: dateTime.hour - DateTime.now().hour,
        minutes: dateTime.minute - DateTime.now().minute,
        seconds: dateTime.second - DateTime.now().second,
      );
    }

    // addTimer();
  }
//Change Prayer Name

  String updatePrayer(String prayer) {
    if (prayer == 'ishabefore' &&
        correctDate(prayerTimes.ishaStartTime!).isBefore(DateTime.now())) {
      prayer = "fajr";
    }
    if (prayer == 'fajrafter') {
      prayer = "fajr";
    }
    if (prayer == "isha" &&
        correctDate(prayerTimes.ishaStartTime!).isAfter(DateTime.now())) {
      prayer = "maghrib";
    }

    if (prayer == "sunrise" &&
        correctDate(prayerTimes.sunrise!).isAfter(DateTime.now())) {
      prayer = "fajr";
    }
    if (prayer.contains("fajr")) {
      if (DateTime.now()
              .isAfter(dateAfter30minutes(prayerTimes.fajrStartTime!)) &&
          prayerTimes.nextPrayer() != "fajrafter") {
        prayer = "sunrise";
      }
    }
    if (prayer.contains("sunrise")) {
      if (DateTime.now().isAfter(dateAfter30minutes(prayerTimes.sunrise!))) {
        prayer = "dhuhr";
      }
    }
    if (prayer.contains("dhuhr")) {
      if (DateTime.now()
          .isAfter(dateAfter30minutes(prayerTimes.dhuhrStartTime!))) {
        prayer = "asr";
      }
    }
    if (prayer.contains("asr")) {
      if (DateTime.now()
          .isAfter(dateAfter30minutes(prayerTimes.asrStartTime!))) {
        prayer = "maghrib";
      }
    }
    if (prayer.contains("maghrib")) {
      if (DateTime.now()
          .isAfter(dateAfter30minutes(prayerTimes.maghribStartTime!))) {
        prayer = "isha";
      }
    }
    if (prayer.contains("isha")) {
      if (DateTime.now()
          .isAfter(dateAfter30minutes(prayerTimes.ishaStartTime!))) {
        prayer = "fajr";
      }
    }
    return prayer;
  }

  void updateImage(String prayer) {
    prayer = updatePrayer(prayer);
    currentPrayer = prayer;

    switch (prayer) {
      case "fajr":
        currentImage = fajreImage;
        break;
      case "sunrise":
        currentImage = sunriseImag;
        break;
      case "dhuhr":
        currentImage = dohreImage;
        break;
      case "asr":
        currentImage = asreImage;
        break;
      case "maghrib":
        currentImage = maghribImage;
        break;
      case "isha":
        currentImage = ishaImage;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('1=======>  $currentPrayer');
    print('2=======>  $timerPray');
    Color textColor = dayTextcolor;
    if (currentImage == ishaImage || currentImage == fajreImage) {
      textColor = nightTextColor;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 213, 229, 255),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                currentImage,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                LocationWidget(
                    placeName, changeCity, changeCityLocation, textColor),
                DatePickerWidget(date, setPrayerTime, textColor),
                SinglePrayTimeTile(
                    "Fajr",
                    DateFormat("jm").format(prayerTimes.fajrStartTime!),
                    timerPray == "fajr",
                    currentPrayer == "fajr",
                    endPrayer,
                    currentPrayer == 'fajr' ? nightTextColor2 : textColor),
                SinglePrayTimeTile(
                    "Sunrise",
                    DateFormat("jm").format(prayerTimes.sunrise!),
                    currentPrayer == "sunrise",
                    timerPray == "sunrise",
                    endPrayer,
                    textColor),
                SinglePrayTimeTile(
                    "Dhuhr",
                    DateFormat("jm").format(prayerTimes.dhuhrStartTime!),
                    currentPrayer == "dhuhr",
                    timerPray == "dhuhr",
                    endPrayer,
                    textColor),
                SinglePrayTimeTile(
                    "Asr",
                    DateFormat("jm").format(prayerTimes.asrStartTime!),
                    currentPrayer == "asr",
                    timerPray == "asr",
                    endPrayer,
                    textColor),
                SinglePrayTimeTile(
                    "Maghrib",
                    DateFormat("jm").format(prayerTimes.maghribStartTime!),
                    currentPrayer == "maghrib",
                    timerPray == "maghrib",
                    endPrayer,
                    textColor),
                SinglePrayTimeTile(
                    "Isha",
                    DateFormat("jm").format(prayerTimes.ishaStartTime!),
                    currentPrayer == "isha",
                    timerPray == "isha",
                    endPrayer,
                    currentPrayer == 'isha' ? nightTextColor2 : textColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
