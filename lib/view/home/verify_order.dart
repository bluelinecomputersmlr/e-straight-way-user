import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/controller/home/verify_order_controller.dart';
import 'package:estraightwayapp/controller/home/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOrderPage extends StatelessWidget {
  const VerifyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var verifyOrderController = Get.put(VerifyOrderController());
    var walletController = Get.put(WalletController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          "Verify Order",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          image: (verifyOrderController
                                      .selectedOrder["businessImage"] !=
                                  null)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    verifyOrderController
                                        .selectedOrder["businessImage"],
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (verifyOrderController
                                        .selectedOrder["businessName"] ==
                                    "")
                                ? "Taxi Booking"
                                : verifyOrderController
                                    .selectedOrder["businessName"],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Text(
                          //   verifyOrderController.selectedOrder["serviceName"],
                          //   style: GoogleFonts.inter(
                          //     fontSize: 16,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // Text(
                          //   "Price: ${verifyOrderController.selectedOrder["price"]}",
                          //   style: GoogleFonts.inter(
                          //     fontSize: 16,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // (verifyOrderController.selectedOrder["price"]) ? Padding(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 20.0, vertical: 10.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Basic Service Charge",
              //           style: GoogleFonts.inter(
              //             fontSize: 15.0,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         Text(
              //           verifyOrderController.selectedOrder["price"],
              //           style: GoogleFonts.inter(
              //             fontSize: 15.0,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Token Advance Amount: ",
                      style: GoogleFonts.inter(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "₹ ${verifyOrderController.selectedOrder["tokenAdvance"]}",
                      style: GoogleFonts.inter(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 20.0, vertical: 10.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "CGST",
              //         style: GoogleFonts.inter(
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       Text(
              //         "9%",
              //         style: GoogleFonts.inter(
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "* Inclusive of all taxes.",
                      style: GoogleFonts.inter(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Divider(
                  color: Colors.black,
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
                child: Text(
                  "Choose Payment Option",
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (int.parse(walletController.walletAmount.toString()) >
                          int.parse(verifyOrderController
                              .bookingData["basicChargePaid"])) {
                        verifyOrderController.toggleWalletPaymentOption(
                            !verifyOrderController.useWalletMoney.value);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: verifyOrderController.useWalletMoney.value
                              ? Colors.blue
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Center(
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: verifyOrderController
                                            .useWalletMoney.value
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child:
                                    verifyOrderController.useWalletMoney.value
                                        ? Center(
                                            child: Container(
                                              height: 20.0,
                                              width: 20.0,
                                              decoration: BoxDecoration(
                                                color: verifyOrderController
                                                        .useWalletMoney.value
                                                    ? Colors.blue
                                                    : Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                            ),
                                          )
                                        : Container(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pay using wallet balance",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Balance ₹ ${walletController.walletAmount.toString()}",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  // verifyOrderController.submitData(context);
                  if (verifyOrderController.useWalletMoney.value) {
                    verifyOrderController.payUsingWallet(context);
                  } else {
                    verifyOrderController.pay(context);
                  }
                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.90,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "₹ ${(num.parse(verifyOrderController.selectedOrder["tokenAdvance"]) < 10) ? ((num.parse(verifyOrderController.selectedOrder["tokenAdvance"]) * 0.18) + (num.parse(verifyOrderController.selectedOrder["tokenAdvance"]))).toString() : verifyOrderController.selectedOrder["tokenAdvance"]}",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const VerticalDivider(
                            color: Colors.white,
                            thickness: 1,
                          )
                        ],
                      ),
                      Text(
                        "Checkout ",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
