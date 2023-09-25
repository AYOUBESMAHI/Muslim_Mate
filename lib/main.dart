import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:muslim_mate/Providers/AzkarProvider.dart';
import 'package:muslim_mate/Providers/CitiesProvider.dart';
import 'package:muslim_mate/Providers/MosquesProvider.dart';
import 'package:muslim_mate/Providers/PlaceProvider.dart';
import 'package:muslim_mate/Providers/PrayersProvider.dart';
import 'package:muslim_mate/Providers/SuwarProvider.dart';

import 'package:provider/provider.dart';
//Screens
import 'Screens/Home_Screen.dart';
//Utils
import 'Utils/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaceProvider()),
        ChangeNotifierProvider(create: (context) => MosquesProvider()),
        ChangeNotifierProvider(create: (context) => CitiesProvider()),
        ChangeNotifierProvider(create: (context) => PrayersProvider()),
        ChangeNotifierProvider(create: (context) => SuwarProvider()),
        ChangeNotifierProvider(create: (context) => AzkarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Muslim Mate',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor)),
        home: AnimatedSplashScreen(
          splash: appIcon,
          nextScreen: const HomeScreen(),
          splashIconSize: 220,
          splashTransition: SplashTransition.fadeTransition,
        ),
      ),
    );
  }
}
