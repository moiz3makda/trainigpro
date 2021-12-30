import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';

class LocalNotifyManager
{
   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
   var initSetting;
   BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject=>
                  BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS) {
        requestIOSPermission();
      }
    initializePlatform();
  }

   requestIOSPermission(){
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true
      );
   }
   initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('app_notification_icon');
    var initSettingIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceiveNotification notification = ReceiveNotification(
            id: id, title: title, body: body, payload: payload);
        didReceiveLocalNotificationSubject.add(notification);
      }
    );
    initSetting = InitializationSettings(android: initSettingAndroid, iOS: initSettingIOS);
   }

   setOnNotificationReceive(Function onNotificationReceive){
     didReceiveLocalNotificationSubject.listen((notification) {
       onNotificationReceive(notification);

     });
   }

   setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
    onSelectNotification: (payload) async {
      onNotificationClick(payload);
    });
   }

   Future<void> showNotification() async{
    var androidChannel = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true
    );
    var iosChannel = IOSNotificationDetails();
    var PlatformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
        0,
        "Moiz Makda",
        "Notification sent from Moiz Makda's Application",
        PlatformChannel,
        payload: 'New Payload'
    );
   }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification{
  final int id;
  final dynamic title;
  final dynamic body;
  final dynamic payload;
  ReceiveNotification({required this.id, required this.title, required this.body, required this.payload});
}