import 'package:estraightwayapp/controller/home/wallet_controller.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';

import '../../service/home/user_services.dart';
import '../../service/home/wallet_service.dart';

class AddMoneyController extends GetxController {
  var cfPaymentGatewayService = CFPaymentGatewayService();

  var orderId = "";
  String paymentSessionId = "";
  CFEnvironment environment = CFEnvironment.PRODUCTION;

  late BuildContext context;

  var transactionData = {};
  var walletData = {};
  var userData = {};

  @override
  void onInit() {
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
    super.onInit();
  }

//On payment success
  void verifyPayment(String orderIdRef) async {
    transactionData["orderIdRef"] = orderIdRef;
    var walletStatus = await UserServices()
        .updateUserData(userData["userId"], walletData as Map<String, dynamic>);

    if (walletStatus["status"] == "success") {
      var trasactionCreationStatus = await WalletService().createTransactions(
          transactionData["id"], transactionData as Map<String, dynamic>);

      if (trasactionCreationStatus["status"] == "success") {
        var walletController = Get.put(WalletController());
        walletController.loadData();
        Get.back();
      }
    } else {
      Get.back();
      // ignore: use_build_context_synchronously
      showErrorSnackbar(context, "Unable to aply the referal code");
    }
  }

//Handeling payment gate way error
  void onError(CFErrorResponse errorResponse, String orderId) {
    Get.back();
    showErrorSnackbar(context, errorResponse.getMessage().toString());
  }

//Creating seesion
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

//Starting payment gateway
  pay(BuildContext contextParam, Map transData, Map walData, Map userDataParam) async {
    context = contextParam;
    transactionData = transData;
    walletData = walData;
    userData = userDataParam;

    Map order = await BusinessServices().createOrder(
      userDataParam["userName"],
      userDataParam["userId"],
      userDataParam["phoneNumber"],
      "Adding money to wallet",
      // double.parse(bookingData["basicChargePaid"]),
      //TODO: Add real amount
      double.parse(transactionData["amount"].toString()),
      orderId,
    );

    print('Order response --> $order');
    if (order["status"] == "success") {
      paymentSessionId = order["data"]["payment_session_id"];
      orderId = order["data"]["order_id"];
      try {
        var session = createSession();
        List<CFPaymentModes> components = <CFPaymentModes>[];
        var paymentComponent = CFPaymentComponentBuilder().setComponents(components).build();

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
