import 'package:estraightwayapp/payment/payment.dart';
import 'package:flutter/material.dart';

class PaymentInitiationPage extends StatefulWidget {
  const PaymentInitiationPage(
      this.grandTotal, this.markerId, this.paymentOptions);

  final double grandTotal;

  final String markerId;
  final Map<String, dynamic> paymentOptions;
  @override
  State<PaymentInitiationPage> createState() => _PaymentInitiationPageState();
}

class _PaymentInitiationPageState extends State<PaymentInitiationPage> {
  @override
  void initState() {
    PaymentPage(widget.grandTotal, widget.markerId, widget.paymentOptions)
        .openCheckout();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Processing..."),
      ),
    );
  }
}
