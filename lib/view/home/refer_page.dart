import 'package:estraightwayapp/service/home/user_services.dart';
import 'package:estraightwayapp/widget/loading_modal.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../service/home/wallet_service.dart';

class ReferPage extends StatelessWidget {
  ReferPage({super.key});

  final _referalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 15,
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Do you have referal code?",
                        style: GoogleFonts.inter(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: TextField(
                          controller: _referalCodeController,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          var referalCode = _referalCodeController.text;
                          if (referalCode.length > 3) {
                            _handleSubmit(context, referalCode);
                          } else {
                            showErrorSnackbar(
                                context, "Enter valid referal code");
                          }
                        },
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              "Apply",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed("/home");
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _handleSubmit(BuildContext context, String referalCode) async {
  loadingDialogWidget(context);
  var referalResponse = await UserServices().getReferalData(referalCode);

  if (referalResponse["status"] == "success") {
    var userId = referalResponse["data"][0]["uid"];
    var userName = referalResponse["data"][0]["userName"];

    // var walletStatus = await UserServices().updateUserData(userId, data);

    var transactionId = const Uuid().v4();

    var transactionData = {
      "amount": 20,
      "fromUserId": FirebaseAuth.instance.currentUser?.uid,
      "fromUserName": userName,
      "message": "Refer",
      "type": "Refer",
      "createdDate": DateTime.now(),
      "id": transactionId,
      "userId": userId,
      "addedToWallet": false
    };

    var walletStatus = await WalletService()
        .createTransactions(transactionId, transactionData);

    if (walletStatus["status"] == "success") {
      Get.back();
      Get.offAllNamed("/home");
    } else {
      Get.back();
      // ignore: use_build_context_synchronously
      showErrorSnackbar(context, "Unable to apply the referal code");
    }
  } else {
    Get.back();
    // ignore: use_build_context_synchronously
    showErrorSnackbar(context, referalResponse["message"]);
  }
}
