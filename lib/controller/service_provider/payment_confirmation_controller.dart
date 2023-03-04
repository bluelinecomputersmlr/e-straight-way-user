import 'package:estraightwayapp/controller/home/home_service_provider_contoller.dart';
import 'package:estraightwayapp/helper/send_notification.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/service_provider/payment_confirmation_service.dart';
import 'package:estraightwayapp/widget/loading_modal.dart';
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

class PaymentConfirmationController extends GetxController {
  var isLoading = false.obs;

  var cfPaymentGatewayService = CFPaymentGatewayService();

  var orderId = "";
  String paymentSessionId = "";
  CFEnvironment environment = CFEnvironment.PRODUCTION;

  late BuildContext context;

  @override
  void onInit() {
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
    super.onInit();
  }

  void verifyPayment(String orderIdRef) async {
    Map<String, dynamic> userData = {};
    userData["orderIdRef"] = orderIdRef;
    userData["paymentDate"] = DateTime.now();
    userData["isInitialPaymentDone"] = true;
    var response = await PaymentConfirmService()
        .updateServiceProviderPaymentStatus(userData);

    if (response["status"] == "success") {
      Get.back();
      Get.offAllNamed("/homeServiceProviderPage");
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
    final homePageController = Get.put(HomeServiceProviderController());
    var order = await BusinessServices().createOrder(
      homePageController.userData.value.userName.toString(),
      homePageController.userData.value.uid.toString(),
      homePageController.userData.value.phoneNumber.toString(),
      "Service Provider one time payment",
      double.parse("20"),
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
