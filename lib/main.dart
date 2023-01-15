import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:estraightwayapp/view/auth/login_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/get_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Setting Firebse messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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

final box = GetStorage();

void _createNotification(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      channelKey: 'basic_channel',
      title: title,
      body: body,
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
      _createNotification(event.notification!.title.toString(),
          event.notification!.body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _createNotification(message.notification!.title.toString(),
          message.notification!.body.toString());
    });
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
