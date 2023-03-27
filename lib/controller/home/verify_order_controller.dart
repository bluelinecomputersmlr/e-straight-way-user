import 'package:estraightwayapp/controller/home/wallet_controller.dart';
import 'package:estraightwayapp/helper/send_notification.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/home/user_services.dart';
import 'package:estraightwayapp/service/home/wallet_service.dart';
import 'package:estraightwayapp/widget/loading_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../../widget/snackbars.dart';

class VerifyOrderController extends GetxController {
  var selectedOrder = {}.obs;
  var isLoading = false.obs;
  var useWalletMoney = false.obs;

  Map<String, dynamic> bookingData = {};

  var cfPaymentGatewayService = CFPaymentGatewayService();

  var orderId = "";
  String paymentSessionId = "";
  CFEnvironment environment = CFEnvironment.PRODUCTION;

  late BuildContext context;

  @override
  void onInit() {
    loadData();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
    super.onInit();
  }

  Future<LatLng?> getLocation() async {
    Location location = Location();

    bool serviceEnabled = false;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  void loadData() async {
    selectedOrder["uid"] = Get.parameters["uid"];
    selectedOrder["businessImage"] = Get.parameters["businessImage"];
    selectedOrder["price"] = Get.parameters["price"];
    selectedOrder["businessName"] = Get.parameters["businessName"];
    selectedOrder["serviceName"] = Get.parameters["serviceName"];
    selectedOrder["bookingDate"] = Get.parameters["bookingDate"];
    selectedOrder["businessContactNumber"] =
        Get.parameters["businessContactNumber"];
    selectedOrder["tokenAdvance"] = Get.parameters["tokenAdvance"];

    var userData = await HomePageService().getUserData();

    if (userData["status"] == "success") {
      final geo = GeoFlutterFire();

      LatLng? locationData = await getLocation();

      if (locationData == null) {
        return;
      }

      GeoFirePoint location = geo.point(
          latitude: locationData.latitude, longitude: locationData.longitude);
      bookingData["businessId"] = selectedOrder["uid"];
      bookingData["businessName"] = selectedOrder["businessName"];
      bookingData["businessImage"] = selectedOrder["businessImage"];
      bookingData["businessContactNumber"] =
          selectedOrder["businessContactNumber"];
      bookingData["price"] = selectedOrder["price"];
      bookingData["serviceName"] = selectedOrder["serviceName"];
      bookingData["basicChargePaid"] = selectedOrder["tokenAdvance"];
      bookingData["userId"] = userData["user"]["uid"];
      bookingData["userName"] = userData["user"]["userName"];
      bookingData["phoneNumber"] = userData["user"]["phoneNumber"];
      bookingData["bookedDate"] = DateTime.parse(selectedOrder["bookingDate"]);
      bookingData["createdDate"] = DateTime.now();
      bookingData["modifiedDate"] = DateTime.now();
      bookingData["isCompleted"] = false;
      bookingData["isServiceProviderAccepted"] = false;
      bookingData["id"] = const Uuid().v4();
      bookingData["isOrderCompleted"] = false;
      bookingData["isCancelled"] = false;
      bookingData["rating"] = 0;
      bookingData["isRejected"] = false;
      bookingData["status"] = "Requested";
      bookingData["location"] = location.data;
    }
  }

  void toggleWalletPaymentOption(bool value) {
    useWalletMoney.value = value;
  }

  void submitData(BuildContext context) async {
    isLoading(true);
    var response = await BusinessServices().bookService(bookingData);

    if (response["status"] == "success") {
      sendNotification(
          bookingData["businessId"],
          "You have new Service Booking",
          "${bookingData["userName"]} has booked a Service",
          true);
      final snackBar = SnackBar(
        content: const Text(
          "Order Place Successfuly!",
        ),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {},
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(
          response["message"],
        ),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {},
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    isLoading(false);
  }

  void payUsingWallet(BuildContext contextParam) async {
    context = contextParam;
    //Verify order is done for this service or not
    var orderStatus = await BusinessServices().verifyBookings(bookingData);

    if (orderStatus["status"] == "success") {
      bookingData["isWalletPayment"] = false;
      bookingData["orderIdRef"] = "";
      bookingData["paymentDate"] = DateTime.now();
      var response = await BusinessServices().bookService(bookingData);

      if (response["status"] == "success") {
        ///Deduct money from wallet
        var walletController = Get.put(WalletController());
        var walletAmount = walletController.walletAmount.value;
        var bookingAmount = bookingData["basicChargePaid"];
        var remainingWalletBalance = int.parse(walletAmount.toString()) -
            int.parse(bookingAmount.toString());
        var walletUpdateStatus = await UserServices().updateUserData(
            FirebaseAuth.instance.currentUser!.uid,
            {"wallet": remainingWalletBalance});

        if (walletUpdateStatus["status"] == "success") {
          var transactionId = const Uuid().v4();
          var transactionData = {
            "amount": int.parse(bookingAmount.toString()),
            "fromUserId": "",
            "message": "Wallet",
            "type": "Debit",
            "createdDate": DateTime.now(),
            "id": transactionId,
            "userId": FirebaseAuth.instance.currentUser?.uid,
          };
          var transactionCreationStatus = await WalletService()
              .createTransactions(transactionId, transactionData);
        }
        await BusinessServices()
            .depositReferEarnToWallet(FirebaseAuth.instance.currentUser!.uid);
        sendNotification(
            bookingData["businessId"],
            "You have new Service Booking",
            "${bookingData["userName"]} has booked a Service",
            true);
        final snackBar = SnackBar(
          content: const Text(
            "Order Place Successfuly!",
          ),
          action: SnackBarAction(
            label: 'Okay',
            onPressed: () {},
          ),
        );
        Get.back();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.offAllNamed("/bookingsuccessful");
      } else {
        final snackBar = SnackBar(
          content: Text(
            response["message"],
          ),
          action: SnackBarAction(
            label: 'Okay',
            onPressed: () {},
          ),
        );
        Get.back();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // ignore: use_build_context_synchronously
      showErrorSnackbar(context, orderStatus["message"]);
    }
  }

  void verifyPayment(String orderIdRef) async {
    bookingData["isWalletPayment"] = false;
    bookingData["orderIdRef"] = orderIdRef;
    bookingData["paymentDate"] = DateTime.now();
    var response = await BusinessServices().bookService(bookingData);

    if (response["status"] == "success") {
      sendNotification(
          bookingData["businessId"],
          "You have new Service Booking",
          "${bookingData["userName"]} has booked a Service",
          true);
      final snackBar = SnackBar(
        content: const Text(
          "Order Place Successfuly!",
        ),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {},
        ),
      );
      Get.back();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.offAllNamed("/bookingsuccessful");
    } else {
      final snackBar = SnackBar(
        content: Text(
          response["message"],
        ),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {},
        ),
      );
      Get.back();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    final snackBar = SnackBar(
      content: Text(
        errorResponse.getMessage().toString(),
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    Get.back();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  CFSession? createSession() {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      final snackBar = SnackBar(
        content: Text(
          e.message,
        ),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {},
        ),
      );
      Get.back();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  pay(BuildContext contextParam) async {
    context = contextParam;
    loadingDialogWidget(context);
    var order = await BusinessServices().createOrder(
      bookingData["userName"],
      bookingData["userId"],
      bookingData["phoneNumber"],
      "Booking a service",
      // double.parse(bookingData["basicChargePaid"]),
      double.parse("1"),
      orderId,
    );

    if (order["status"] == "success") {
      paymentSessionId = order["data"]["payment_session_id"];
      orderId = order["data"]["order_id"];
      try {
        var session = createSession();
        List<CFPaymentModes> components = <CFPaymentModes>[];
        var paymentComponent =
            CFPaymentComponentBuilder().setComponents(components).build();

        var theme = CFThemeBuilder()
            .setNavigationBarBackgroundColorColor("#5B8CFB")
            .setPrimaryFont("Menlo")
            .setSecondaryFont("Futura")
            .build();

        var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
            .setSession(session!)
            .setPaymentComponent(paymentComponent)
            .setTheme(theme)
            .build();

        cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
      } on CFException catch (e) {
        print(e.message);
      }
    } else {
      print(order);
    }
  }
}
