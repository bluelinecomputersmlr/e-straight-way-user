import 'dart:convert';
//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'routes_via_orders.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart'
    as razorCustom;

class PaymentPage {
  late razorCustom.Razorpay razorpay;
  late String msg;
  final firestoreInstance = FirebaseFirestore.instance;
  final double grandTotal;

  final String markerId;
  Map<String, dynamic> paymentOptions;
  String orderId = '';
  late razorCustom.Razorpay _razorpay;

  PaymentPage(this.grandTotal, this.markerId, this.paymentOptions) {
    razorpay = new razorCustom.Razorpay();
    _razorpay = razorCustom.Razorpay();
    _razorpay.on(
        razorCustom.Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(razorCustom.Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.initilizeSDK("rzp_test_HjmiukVH13l5u3");
  }
  void dispose() {
    razorpay.clear();
  }

  openCheckout() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic cnpwX3Rlc3RfSGptaXVrVkgxM2w1dTM6N2F6bVdlMThnTlRHbTZKYURYTDhWM1Nx'
    };
    var request =
        http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
    // print(grandTotal);
    request.body = json.encode({
      "amount": "${paymentOptions['amount']}",
      "currency": "INR",
      "receipt": "Receipt no. 1",
      // "notes": {
      //   "notes_key_1": "Tea, Earl Grey, Hot",
      //   "notes_key_2": "Tea, Earl Grey… decaf."
      // }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((contents) {
        //print(contents);
        orderId = contents.split(',')[0].split(":")[1];
        orderId = orderId.substring(1, orderId.length - 1);
        paymentOptions['key'] = 'rzp_test_HjmiukVH13l5u3';
        paymentOptions['order_id'] = orderId;
        paymentOptions['description'] = "Order ID: ${orderId}";

        try {
          _razorpay.submit(paymentOptions);
        } catch (e) {}
      });
    } else {
      //print(response.reasonPhrase);
    }
  }

  void handlerPaymentSuccess(Map<dynamic, dynamic> response) async {
    Get.toNamed('/successPaymentPage');
  }

  void handlerErrorFailure(Map<dynamic, dynamic> response) async {
    Get.toNamed('/failedPaymentPage');
  }

  void handlerExternalWallet(Map<dynamic, dynamic> response) {
    // showToast(msg);
  }

  // showToast(msg) {
  //   Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.grey.withOpacity(0.1),
  //     textColor: Colors.black54,
  //   );
  // }
}
