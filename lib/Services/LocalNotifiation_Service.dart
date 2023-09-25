import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin localNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: darwinInitializationSettings);

    await localNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showTextNotification(
      {var id = 0,
      required String title,
      required String message,
      var playLoad,
      required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "my_id",
      'channelName',
      //playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      //sound: RawResourceAndroidNotificationSound(adhan),
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentSound: true);

    var not = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(id, title, message, not);
  }
}
