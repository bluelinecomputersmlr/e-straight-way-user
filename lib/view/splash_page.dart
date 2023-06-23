import 'dart:async';
import 'dart:developer';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/service/home/disclouser_screen.dart';
import 'package:estraightwayapp/view/auth/login_home.dart';
import 'package:estraightwayapp/view/auth/sign_up_page.dart';
import 'package:estraightwayapp/view/auth/sign_up_service_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/home_page.dart';
import 'service_provider/home_service_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/icons/logo/estraightway_logo.png'),
      title: const Text(
        "estraightway",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff3F5C9F)),
      ),
      backgroundImage:
          const AssetImage('assets/icons/splash/splash_background.png'),
      showLoader: true,
      loadingText: const Text("Loading..."),
      durationInSeconds: 5,
      futureNavigator: futureCall(),
    );
  }

  Future<Widget> futureCall() async {
    final prefs = await SharedPreferences.getInstance();
    bool? disco = prefs.getBool('isDisclouser');
    log('Disco --> $disco');
    if (disco == null) {
      return Future.value(const DisclosureScreen());
    }
    print('User --> ${FirebaseAuth.instance.currentUser}');
    if (FirebaseAuth.instance.currentUser != null) {
      var response = await LoginService().loginUser();
      if (response["status"] == "success") {
        UserModel user = UserModel.fromJson(response['user']);
        LoginService().updateUser(user.lastLoggedAsUser == true ? false : true);
        if (user.lastLoggedAsUser == true) {
          return Future.value(const HomePage());
        } else if (user.lastLoggedAsUser == false &&
            user.isServiceProviderRegistered == false) {
          return Future.value(SignUpServiceProviderPage());
        } else if (user.lastLoggedAsUser == false &&
            user.isServiceProviderRegistered == true) {
          return Future.value(const HomeServiceProviderPage());
        } else {
          return Future.value(SignUpPage());
        }
      } else {
        return Future.value(const LoginHomePage());
      }
    } else {
      return Future.value(const LoginHomePage());
    }
  }
}
