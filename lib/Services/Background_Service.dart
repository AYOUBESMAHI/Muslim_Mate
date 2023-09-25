// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'LocalNotifiation_Service.dart';

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//       iosConfiguration: IosConfiguration(
//         autoStart: true,
//         onForeground: onStart,
//         onBackground: onIosBackground,
//       ),
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: false,
//         autoStart: true,
//       ));
// }

// @pragma("vm:entry-point")
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }

// @pragma("vm:entry-point")
// void onStart(ServiceInstance service) {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   LocalNotification.initialize(flutterLocalNotificationsPlugin);
//   DartPluginRegistrant.ensureInitialized();
//   if (service is AndroidServiceInstance) {
//     service.on("setAsForeground").listen((event) {
//       print('-foreground');

//       service.setAsForegroundService();
//     });

//     service.on("setAsBackground").listen((event) {
//       print('-background');

//       service.setAsBackgroundService();
//     });
//   }
//   service.on("stopService").listen((event) {
//     print('stooop');

//     service.stopSelf();
//   });
//   Timer.periodic(const Duration(seconds: 30), (timer) async {
//     print("ffff");
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         print('foreground');

//         service.setForegroundNotificationInfo(
//             title: "ForeGround", content: "This happen in foregound");
//       } else {
//         print('background');
//         LocalNotification.showTextNotification(
//             title: 'This is BackGround',
//             message: 'This happen in backgroun we collect your data',
//             flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
//         service.setForegroundNotificationInfo(
//             title: "Background", content: "This happen in BackGround");
//       }
//     }
//     service.invoke("update");
//   });
// }
