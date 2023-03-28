import 'package:estraightwayapp/controller/home/bookings_controller.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var bookingController = Get.put(BookingsController());

    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Obx(
        () => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Bookings",
                style: GoogleFonts.inter(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            (bookingController.isLoading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (bookingController.bookingsData.isNotEmpty)
                    ? StreamBuilder(
                        stream: bookingController.getBookingsStream(),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>?> snapshot) {
                          return (!snapshot.hasData)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: size.width,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 5,
                                            offset: const Offset(
                                              0,
                                              3,
                                            ), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.40),
                                                child: (snapshot.data![index][
                                                                "businessImage"] ==
                                                            "null" ||
                                                        snapshot.data![index][
                                                                "businessImage"] ==
                                                            "" ||
                                                        snapshot.data![index][
                                                                "businessImage"] ==
                                                            null)
                                                    ? SizedBox(
                                                        height:
                                                            size.width * 0.30,
                                                        width:
                                                            size.width * 0.30,
                                                      )
                                                    : Image.network(
                                                        snapshot.data![index]
                                                            ["businessImage"],
                                                        height:
                                                            size.width * 0.30,
                                                        width:
                                                            size.width * 0.30,
                                                      ),
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 0.50,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          ["businessName"],
                                                      style: GoogleFonts.inter(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Uri phoneno = Uri.parse(
                                                          'tel:${snapshot.data![index]["businessContactNumber"]}');
                                                      if (await launchUrl(
                                                          phoneno)) {
                                                        //dialer opened
                                                      } else {
                                                        //dailer is not opened
                                                      }
                                                    },
                                                    child: SizedBox(
                                                      width: size.width * 0.50,
                                                      child: Text(
                                                        snapshot.data![index][
                                                            "businessContactNumber"],
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.50,
                                                    child: Text(
                                                      DateFormat('dd/MM/yyyy')
                                                          .add_jm()
                                                          .format(snapshot
                                                              .data![index]
                                                                  ["bookedDate"]
                                                              .toDate()),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: size.width * 0.40,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    color: (snapshot
                                                                .data![index][
                                                            "isServiceProviderAccepted"])
                                                        ? (snapshot.data![index]
                                                                [
                                                                "isOrderCompleted"])
                                                            ? Colors.green
                                                            : Colors.blue
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Text(
                                                  (snapshot.data![index][
                                                          "isServiceProviderAccepted"])
                                                      ? (snapshot.data![index][
                                                              "isOrderCompleted"])
                                                          ? "Completed"
                                                          : "Accepted"
                                                      : (snapshot.data![index][
                                                                  "isUserCancelled"] !=
                                                              null)
                                                          ? (snapshot.data![
                                                                      index][
                                                                  "isUserCancelled"])
                                                              ? "Cancelled"
                                                              : "Pending"
                                                          : "Pending",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              (snapshot.data![index][
                                                          "isOrderCompleted"] &&
                                                      snapshot.data![index]
                                                              ["rating"] !=
                                                          0)
                                                  ? Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        Text(
                                                          (snapshot.data![index]
                                                                  ["rating"])
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .inter(),
                                                        )
                                                      ],
                                                    )
                                                  : Container(),
                                              const SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.80,
                                                child: Text(
                                                  "Token Advance: ₹${snapshot.data![index]["basicChargePaid"]}",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: size.width * 0.40,
                                              //   child: Text(
                                              //     "Price: ₹${snapshot.data![index]["price"]}",
                                              //     style: GoogleFonts.inter(
                                              //       fontSize: 17.0,
                                              //       fontWeight: FontWeight.w600,
                                              //     ),
                                              //     overflow:
                                              //         TextOverflow.ellipsis,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          (snapshot.data![index]
                                                      ["isOrderCompleted"] &&
                                                  snapshot.data![index]
                                                          ["rating"] ==
                                                      0)
                                              ? GestureDetector(
                                                  onTap: () {
                                                    final reviewController =
                                                        TextEditingController();
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: Obx(
                                                            () => Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    Image.asset(
                                                                      "assets/icons/rate.png",
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          Text(
                                                                        "Please share your feedback, your feedback will help us improve our services.",
                                                                        style: GoogleFonts
                                                                            .inter(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              bookingController.setRating(1);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              (bookingController.givenRating.value >= 1) ? Icons.star : Icons.star_border,
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              bookingController.setRating(2);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              (bookingController.givenRating.value >= 2) ? Icons.star : Icons.star_border,
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              bookingController.setRating(3);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              (bookingController.givenRating.value >= 3) ? Icons.star : Icons.star_border,
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              bookingController.setRating(4);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              (bookingController.givenRating.value >= 4) ? Icons.star : Icons.star_border,
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              bookingController.setRating(5);
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              (bookingController.givenRating.value >= 5) ? Icons.star : Icons.star_border,
                                                                              color: Colors.amber,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            reviewController,
                                                                        maxLines:
                                                                            4,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(5.0)),
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey),
                                                                          ),
                                                                          focusedBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(5.0)),
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey),
                                                                          ),
                                                                          labelText:
                                                                              "Comment",
                                                                          labelStyle:
                                                                              GoogleFonts.inter(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        var rating = bookingController
                                                                            .givenRating
                                                                            .value;

                                                                        var comments =
                                                                            reviewController.text;

                                                                        var bookingId =
                                                                            snapshot.data![index]["id"];

                                                                        var data =
                                                                            {
                                                                          "rating":
                                                                              rating,
                                                                          "comments":
                                                                              comments,
                                                                        };

                                                                        await BusinessServices().updateBookingsData(
                                                                            bookingId,
                                                                            data);

                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40.0,
                                                                        width: size.width *
                                                                            0.40,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: const Color.fromRGBO(
                                                                              63,
                                                                              92,
                                                                              159,
                                                                              1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Submit",
                                                                            style:
                                                                                GoogleFonts.inter(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40.0,
                                                    width: size.width * 0.40,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF3F5C9F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Rate & Review",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (!snapshot.data![index][
                                                      "isServiceProviderAccepted"] &&
                                                  snapshot.data![index]
                                                          ["isUserCancelled"] ==
                                                      null)
                                              ? GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            "Are you want to cancel?",
                                                          ),
                                                          titleTextStyle:
                                                              GoogleFonts.inter(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.0,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                var data = {
                                                                  "isUserCancelled":
                                                                      true,
                                                                  "userCancelledDate":
                                                                      DateTime
                                                                          .now(),
                                                                  "isRefunded":
                                                                      false,
                                                                };

                                                                var bookingId =
                                                                    snapshot.data![
                                                                            index]
                                                                        ["id"];

                                                                var cancelStatus =
                                                                    await BusinessServices()
                                                                        .updateBookingsData(
                                                                            bookingId,
                                                                            data);

                                                                if (cancelStatus[
                                                                        "status"] ==
                                                                    "success") {
                                                                  await BusinessServices().refundMoney(
                                                                      snapshot.data![
                                                                              index]
                                                                          [
                                                                          "userId"],
                                                                      int.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                              [
                                                                              "basicChargePaid"]
                                                                          .toString()));
                                                                  final snackBar =
                                                                      SnackBar(
                                                                    content:
                                                                        const Text(
                                                                      "Booking Cancelled Successfully",
                                                                    ),
                                                                    action:
                                                                        SnackBarAction(
                                                                      label:
                                                                          'Okay',
                                                                      onPressed:
                                                                          () {},
                                                                    ),
                                                                  );
                                                                  // ignore: use_build_context_synchronously
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);
                                                                  Get.back();
                                                                } else {
                                                                  final snackBar =
                                                                      SnackBar(
                                                                    content:
                                                                        const Text(
                                                                      "Unable to cancel the order",
                                                                    ),
                                                                    action:
                                                                        SnackBarAction(
                                                                      label:
                                                                          'Okay',
                                                                      onPressed:
                                                                          () {},
                                                                    ),
                                                                  );
                                                                  // ignore: use_build_context_synchronously
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackBar);
                                                                  Get.back();
                                                                }
                                                              },
                                                              child: Text(
                                                                "Confirm",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40.0,
                                                    width: size.width * 0.40,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF3F5C9F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Cancel Booking",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        })
                    : Center(
                        child: Text(
                          "No bookings found",
                          style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
