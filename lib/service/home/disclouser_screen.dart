import 'package:estraightwayapp/view/auth/login_home.dart';
import 'package:estraightwayapp/view/home/privacy_policy.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisclosureScreen extends StatefulWidget {
  const DisclosureScreen({Key? key}) : super(key: key);

  @override
  State<DisclosureScreen> createState() => _DisclosureScreenState();
}

class _DisclosureScreenState extends State<DisclosureScreen> {
  var height;
  var width;
  bool isChecked = false;
  bool isLoading = false;

  // ThemeManager themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    // logs('Current screen --> $runtimeType');
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Image(
                image: AssetImage(
                  "assets/icons/logo/estraightway_logo.png",
                ),
                height: height * 0.2),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Text('EStraightway Rider in disclosure',
                  style: TextStyle(fontSize: height * 0.022, fontWeight: FontWeight.w500)),
            ),
            Divider(),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
                'This app collects location data to enable live tracking of pickup and delivery of orders even when the app is closed or not in use.'),
            SizedBox(
              height: height * 0.02,
            ),
            Text('This data will be uploaded to sparkleUp.us where you may view and/or delete your location history.'),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
                'Our app is designed to help delivery boys using EStraightway find the quickest and most optimal route to their delivery destination. To do this, we need to know your location at all times, even when the app is running in the background. This allows us to track your progress in real-time and provide you with accurate and up-to-date information on your delivery route.'),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
                'Without continuous access to your location, EStraightway may not be able to provide the most efficient route to your destination, leading to delays and dissatisfied customers. Therefore, we need to continuously track your location to ensure that you can complete your deliveries in the most efficient way possible.'),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
                'We understand that privacy is important to our users, and we want to assure you that we take the security and privacy of your data very seriously. We only use your location data for the purpose of providing you with the best delivery service possible through EStraightway, and we do not share your data with any third-party entities.'),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
                'If you have any further questions or concerns about how we use your location data, please donot hesitate to contact us. We are committed to providing you with a reliable and efficient delivery service through EStraightway, and we appreciate your trust in our app.'),
            SizedBox(
              height: height * 0.03,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy(),
                      ));
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.blue),
                )),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: Row(
                children: [
                  Icon(
                    isChecked ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                    color: isChecked ? Colors.blueAccent : Colors.black,
                    size: 25,
                  ),
                  SizedBox(
                    width: height * 0.02,
                  ),
                  Expanded(
                    child: Text(
                      'I have read and agree to the privacy policy and terms of use.',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                if (isChecked) checkStatus();
              },
              child: Container(
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    color: isChecked ? Colors.blue : Colors.grey,
                  ),
                  alignment: Alignment.center,
                  width: width * 0.4,
                  child: isLoading == true
                      ? CircularProgressIndicator()
                      : Text(
                          'Proceed to Login',
                          style: TextStyle(color: Colors.white),
                        )),
            )
          ],
        ),
      ),
    ));
  }

  void checkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDisclouser', true);
    isLoading = false;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginHomePage(),
        ),
        (route) => false);
  }
}
