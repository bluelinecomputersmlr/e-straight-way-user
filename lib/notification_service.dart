import 'package:dio/dio.dart';
import 'package:estraightwayapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._privateConstructor();

  static final NotificationService instance = NotificationService._privateConstructor();
  String? fcmToken;
  FirebaseMessaging? firebaseMessaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await initializeNotification();
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'CHANNEL ID',
      'CHANNEL NAME',
      channelDescription: 'CHANNEL DESCRIPTION',
      importance: Importance.max,
      priority: Priority.max,
      enableLights: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );
    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.aiff',
    );
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.schedule(
      1,
      remoteMessage.notification!.title ?? '',
      remoteMessage.notification!.body ?? '',
      DateTime.now(),
      notificationDetails,
      payload: remoteMessage.notification!.title ?? '',
    );
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print('Handling a background message ${remoteMessage.messageId}');
  }

  Future<void> initializeNotification() async {
    await Firebase.initializeApp();
    await initializeLocalNotification();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    fcmToken = await firebaseMessaging.getToken();
    print('FCM Token --> $fcmToken');
    FirebaseMessaging.onBackgroundMessage((message) => firebaseMessagingBackgroundHandler(message));

    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(announcement: true);

    print('Notification permission status : ${notificationSettings.authorizationStatus.name}');
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
        print('Message title: ${remoteMessage.notification!.title}, body: ${remoteMessage.notification!.body}');

        AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
          'CHANNEL ID',
          'CHANNEL NAME',
          channelDescription: 'CHANNEL DESCRIPTION',
          importance: Importance.max,
          priority: Priority.max,
          enableLights: true,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
        );
        DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'notification_sound.aiff',
        );
        NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);

        await flutterLocalNotificationsPlugin.schedule(
          1,
          remoteMessage.notification!.title ?? '',
          remoteMessage.notification!.body ?? '',
          DateTime.now(),
          notificationDetails,
          payload: remoteMessage.notification!.title ?? '',
        );
      });
    }
  }

  initializeLocalNotification() {
    AndroidInitializationSettings android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings ios = const DarwinInitializationSettings();
    InitializationSettings platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
  }

  Future<void> sendNotification(fcmToken, msg) async {
    Dio dio = Dio();
    dio.post(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAiRf-MyQ:APA91bHoigGIr-QjP4fbAzbqXdx68g54KUaZ2G_6fD8yrimE4oPAvBzQkAMHEx9SwJ9H44uwXWGeIx470FPKA_1dYNdwhWqd_FpWkhqkQRsLCfSqTDyDxYj_ddaeIlijK3djGEMzYpc0"
        },
      ),
      data: {
        "to": fcmToken,
        "notification": {
          "title": "E-StraightWay",
          "body": msg,
          "mutable_content": false,
          "sound": "notification_sound"
        },
      },
    );
  }
}
