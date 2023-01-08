import 'package:estraightwayapp/view/auth/login_home.dart';
import 'package:estraightwayapp/view/auth/login_home_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/get_pages.dart';
import 'package:estraightwayapp/view/auth/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final box = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
