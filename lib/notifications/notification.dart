import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:timezone/timezone.dart" as timeZone;

class NotificationServiceClass {
  static final NotificationServiceClass _notificationServiceClass =
      NotificationServiceClass._internal();
  static final flutterLocalNotifications = FlutterLocalNotificationsPlugin();

  factory NotificationServiceClass() {
    return _notificationServiceClass;
  }

  NotificationServiceClass._internal();

  Future<void> initNotifications() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("notification_icon");
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotifications.initialize(initializationSettings);
  }

  Future<void> showNotifications(
    int id,
    String title,
    String body,
     {String ?date,String? time}
  ) async {
    List<String>?dateSplit=date?.split("/");
    List<String>?timeSplit=time?.split(":");
    String? year=dateSplit?[2].trim();
    String ?month=dateSplit?[0].trim();
    String ?day=dateSplit?[1].trim();
    String ?hour=timeSplit?[0].trim();
    String ?minute=timeSplit?[1].trim();
    print(year);
    print(month);
    print(day);
    print(hour);
    print(minute);
    await flutterLocalNotifications.zonedSchedule(
        id,
        title,
        body,
        //timeZone.TZDateTime.now(timeZone.local),
        timeZone.TZDateTime.local(int.parse(year??""),int.parse(month??""),int.parse(day??""),int.parse(hour??""),int.parse(minute??"")).add(Duration(seconds: 5)),
        const NotificationDetails(
          android: AndroidNotificationDetails("main_channel1", "main__channel2",
              importance: Importance.max, priority: Priority.max),
          iOS: IOSNotificationDetails(sound: "default.wav"),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<void>cancelNotification()async{
    await flutterLocalNotifications.cancelAll();
  }
// static Future showNotificationMethod(String title,String body)async{
//   return notifications.show(0, title, body, await notificationDetails(),payload: "todo.app");
// }
//  static Future notificationDetails()async{
//    return NotificationDetails(
//      android: AndroidNotificationDetails(
//        'channel id',
//        'channel name',
//        channelDescription: 'channel description',
//        importance: Importance.max,
//      ),
//      iOS: IOSNotificationDetails(),
//    );
//  }
}
