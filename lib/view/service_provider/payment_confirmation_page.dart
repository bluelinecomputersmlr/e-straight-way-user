import 'package:estraightwayapp/controller/home/verify_order_controller.dart';
import 'package:estraightwayapp/controller/service_provider/payment_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentConfirmationPage extends StatelessWidget {
  const PaymentConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var verifyOrderController = Get.put(PaymentConfirmationController());
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Payment",
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.20,
          ),
          Text(
            "Please do one time payment of rupees",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "₹ 20",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              verifyOrderController.pay(context);
            },
            child: Container(
              height: 50.0,
              width: size.width,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  "Pay",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
