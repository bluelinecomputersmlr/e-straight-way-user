// import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SuccessPaymentPage extends StatefulWidget {
  // const SuccessPaymentPage({required this.response, required this.spaceId});
  // final Map<dynamic, dynamic> response;
  // final String spaceId;
  @override
  State<SuccessPaymentPage> createState() => _SuccessPaymentPageState();
}

class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pop(context);
      Navigator.pop(context);
      // Navigator.pop(context);
      // Navigator.pop(context);
      // HttpsCallable callable =
      //     FirebaseFunctions.instanceFor(region: 'asia-south1')
      //         .httpsCallable('paymentProcessingRentl');
      //
      // final resp = await callable.call({
      //   'spaceId': widget.spaceId,
      //   'isTransactionSuccessful': true,
      //   'transactionId': widget.response['data']['razorpay_order_id'],
      //   'paymentId': widget.response['data']['razorpay_payment_id'],
      // });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset('assets/icons/success.json', repeat: false),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Payment Success',
                style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset('assets/icons/success.json'),
              ),
              // Padding(
              //   padding: Theme.of(context).textTheme.paddingSymmetricOnlT30,
              //   child: Text(
              //     'Booking Success',
              //     style: GoogleFonts.nunito(
              //         fontSize: 30,
              //         fontWeight: FontWeight.w800,
              //         color: Colors.green),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class FailedPage extends StatefulWidget {
  // const FailedPage({required this.orderId, required this.spaceId});
  // final String orderId;
  // final String spaceId;

  @override
  State<FailedPage> createState() => _FailedPageState();
}

class _FailedPageState extends State<FailedPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pop(context);
      Navigator.pop(context);

      //   HttpsCallable callable =
      //       FirebaseFunctions.instanceFor(region: 'asia-south1')
      //           .httpsCallable('paymentProcessingRentl');
      //
      //   final resp = await callable.call({
      //     'spaceId': widget.spaceId,
      //     'isTransactionSuccessful': false,
      //     'transactionId': widget.orderId,
      //     'paymentId': null,
      //   });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset('assets/icons/failed.json', repeat: false),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Payment failed',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
