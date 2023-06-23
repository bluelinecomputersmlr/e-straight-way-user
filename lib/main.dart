import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:estraightwayapp/notification_service.dart';
import 'package:estraightwayapp/view/auth/login_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/get_pages.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Noti.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

///This is to handle the background notification
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Noti.showBigTextNotification(
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString(),
      fln: flutterLocalNotificationsPlugin);
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Setting Firebse messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationService.instance.initializeNotification();
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //Flutter awesome notification setup

  await AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: "Channel Description",
        defaultColor: Colors.blue.shade800,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: "Channel Description",
        defaultColor: Colors.blue.shade800,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
      ),
    ],
  );

  runApp(const MyApp());
}

// void backgroundFetchCallback(String taskId) async {
//   // Retrieve the notification payload
//   RemoteMessage? remoteMessage =
//       await FirebaseMessaging.instance.getInitialMessage();
//   if (remoteMessage != null &&
//       remoteMessage.notification != null &&
//       remoteMessage.data['sound'] != null) {
//     // Play the custom sound

//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//       'CHANNEL ID',
//       'CHANNEL NAME',
//       channelDescription: 'CHANNEL DESCRIPTION',
//       importance: Importance.max,
//       priority: Priority.max,
//       enableLights: true,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//     );
//     DarwinNotificationDetails iosNotificationDetails =
//         const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//       sound: 'notification_sound.aiff',
//     );
//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);

//     // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin.schedule(
//       1,
//       remoteMessage.notification!.title ?? '',
//       remoteMessage.notification!.body ?? '',
//       DateTime.now(),
//       notificationDetails,
//       payload: remoteMessage.notification!.title ?? '',
//     );
//   }

//   BackgroundFetch.finish(taskId);
// }

// void configureBackgroundFetch() {
//   BackgroundFetch.configure(
//     BackgroundFetchConfig(
//       minimumFetchInterval: 15, // Minimum fetch interval in minutes
//       stopOnTerminate:
//           false, // Continue running the background task even if the app is terminated
//       enableHeadless: true, // Enable background execution even in headless mode
//       startOnBoot:
//           true, // Start the background task when the device is restarted
//     ),
//     (String taskId) =>
//         backgroundFetchCallback(taskId), // Pass taskId to the callback
//   );
// }

final box = GetStorage();

void _createNotification(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      channelKey: 'basic_channel',
      title: 'title',
      body: 'body',
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      Noti.showBigTextNotification(
          title: event.notification!.title.toString(),
          body: event.notification!.body.toString(),
          fln: flutterLocalNotificationsPlugin);
      // _createNotification(event.notification!.title.toString(),
      //     event.notification!.body.toString());
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   Noti.showBigTextNotification(
    //       title: message.notification!.title.toString(),
    //       body: message.notification!.body.toString(),
    //       fln: flutterLocalNotificationsPlugin);
    //   // _createNotification(message.notification!.title.toString(),
    //   //     message.notification!.body.toString());
    // });
    // FirebaseMessaging.onBackgroundMessage((message) => NotificationService
    //     .instance
    //     .firebaseMessagingBackgroundHandler(message));

/*    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      log('notification :: ${notification!.body}');
      if (notification.body!.contains('Your have a new Service request')) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewBookings(),
            ));
      }
    });*/

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    Noti.initialize(flutterLocalNotificationsPlugin);

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'E Straightway App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: "/splash",
            getPages: pages,
            debugShowCheckedModeBanner: false,
            home: const LoginHomePage(),
          );
        });
  }
}
