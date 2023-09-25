import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:muslim_mate/Screens/AzkarSections_Screen.dart';
import 'package:muslim_mate/Screens/Compass_Screen.dart';
import 'package:muslim_mate/Screens/Masjid_Screen.dart';
import 'package:muslim_mate/Screens/QuranList_Screen.dart';
import 'package:muslim_mate/Screens/Tasbih_Screen.dart';
import 'package:muslim_mate/Services/GeoLocation_Service.dart';

import 'PrayerTimes_Screen.dart';
import '../Widgets/SingleHomeButton.dart';
import '../Utils/Constants.dart';
import '../Services/SavingData_Service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePrayerNotification();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // var prayers = await getPrayers();
    // for (var p in prayers) {
    //   print("${p.name} **** ${p.time}");
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              "Assets/Images/3D_Animation_Style_cyber_mosque_4.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            alignment: Alignment.topCenter,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: const Color.fromARGB(255, 114, 180, 234)
                            .withOpacity(.35),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Prayer Screen
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const PrayerTimesScreen()))
                                    .then((value) async {
                                  var prayers = await getPrayers();
                                  for (var p in prayers) {
                                    print("${p.name} **** ${p.time}");
                                  }
                                }),
                                child: const SingleHomeButton(
                                    "Prayer Times", prayerIcon),
                              )),
                              //Qibla Screen
                              Expanded(
                                  child: GestureDetector(
                                onTap: () async {
                                  try {
                                    bool isAtive = await checkServiceLocation();
                                    if (isAtive) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const CompassScreen()));
                                    }
                                  } catch (err) {
                                    print('$err');
                                  }
                                },
                                child: const SingleHomeButton(
                                    "Qibla Direction", qiblaIcon),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () async {
                                  try {
                                    bool isAtive = await checkServiceLocation();
                                    if (isAtive) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const MasjidScreen()));
                                    }
                                  } catch (err) {
                                    print('$err');
                                  }
                                },
                                child: const SingleHomeButton(
                                    "Masjid Finder", mosqueIcon),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const QuranListScreen())),
                                      child: const SingleHomeButton(
                                          "Read Quran", quranIcon))),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const AzkarSectionScreen())),
                                      child: const SingleHomeButton(
                                          "Dua", duaIcon))),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const TasbihScreen())),
                                      child: const SingleHomeButton(
                                          "Tasbeeh", tasbihIcon))),
                            ],
                          ),
                        ],
                      ),
                    ))),
          ),
        ]),
      ),
    );
  }
}
