import 'package:estraightwayapp/controller/home/home_service_provider_contoller.dart';
import 'package:estraightwayapp/controller/service_provider/new_booking_controller.dart';
import 'package:estraightwayapp/helper/send_notification.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewBookings extends StatelessWidget {
  const NewBookings({super.key});

  @override
  Widget build(BuildContext context) {
    var newBookingsController = Get.put(NewBookingController());
    var homePageController = Get.put(HomeServiceProviderController());

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: const Color(0xFFCEEED9),
      body: ListView(
        children: [
          Image.asset('assets/icons/wave.png'),
          const SizedBox(
            height: 20.0,
          ),
          //App Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30.0,
                  color: Color(0xFF3F5C9F),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo/estraightway_logo_service_provider.png',
                    width: MediaQuery.of(context).size.width * 0.40,
                  ),
                  Center(
                    child: Text(
                      "Service Provider",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3F5C9F),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),

          //App Bar Ends Here
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "New Bookings",
            style: GoogleFonts.inter(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF727272),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20.0,
          ),

          StreamBuilder(
              stream: newBookingsController.getBookingsStream(),
              builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
                return (!snapshot.hasData)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data![index]["userName"],
                                  style: GoogleFonts.inter(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  snapshot.data![index]["businessName"],
                                  style: GoogleFonts.inter(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF727272),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                // Text(
                                //   newBookingsController.bookings[index]
                                //           ["subCategory"]
                                //       .toString(),
                                //   style: GoogleFonts.inter(
                                //     fontSize: 15.0,
                                //     fontWeight: FontWeight.w500,
                                //     color: const Color(0xFF727272),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 10.0,
                                // ),
                                Text(
                                  snapshot.data![index]["phoneNumber"],
                                  style: GoogleFonts.inter(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF727272),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var bookingId = snapshot.data![index]["id"];
                                    Map<String, dynamic> data = {};
                                    if (homePageController
                                            .userData
                                            .value
                                            .serviceProviderDetails!
                                            .businessType ==
                                        "map") {
                                      data = {
                                        "businessId": homePageController
                                            .userData
                                            .value
                                            .serviceProviderDetails!
                                            .businessUID,
                                        "businessContactNumber":
                                            homePageController
                                                .userData.value.phoneNumber,
                                        "isServiceProviderAccepted": true,
                                        "acceptedDate": DateTime.now(),
                                        "status": "Approved",
                                      };
                                    } else {
                                      data = {
                                        "isServiceProviderAccepted": true,
                                        "acceptedDate": DateTime.now(),
                                        "status": "Approved",
                                      };
                                    }
                                    await BusinessServices()
                                        .updateBookingsData(bookingId, data);

                                    sendNotification(
                                      snapshot.data![index]["userId"],
                                      "Your booking request got accepted",
                                      "${snapshot.data![index]["businessName"]} accepted your booking",
                                      false,
                                    );
                                  },
                                  child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Confirm Request",
                                        style: GoogleFonts.inter(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                (homePageController
                                            .userData
                                            .value
                                            .serviceProviderDetails!
                                            .businessType !=
                                        "map")
                                    ? GestureDetector(
                                        onTap: () async {
                                          var bookingId =
                                              snapshot.data![index]["id"];
                                          var data = {
                                            "isServiceProviderAccepted": false,
                                            "isRejected": true,
                                            "rejectedDate": DateTime.now(),
                                            "status": "Rejected",
                                          };
                                          await BusinessServices()
                                              .updateBookingsData(
                                                  bookingId, data);
                                          await BusinessServices().refundMoney(
                                            snapshot.data![index]["userId"],
                                            int.parse(
                                              snapshot.data![index]
                                                      ["basicChargePaid"]
                                                  .toString(),
                                            ),
                                          );
                                          sendNotification(
                                            snapshot.data![index]["userId"],
                                            "Your booking request got rejected",
                                            "${snapshot.data![index]["businessName"]} rejected your booking",
                                            false,
                                          );
                                        },
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Cancel Request",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(snapshot
                                          .data![index]["bookedDate"]
                                          .toDate()),
                                      style: GoogleFonts.inter(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF727272),
                                      ),
                                    ),
                                    Text(
                                      DateFormat().add_jm().format(snapshot
                                          .data![index]["bookedDate"]
                                          .toDate()),
                                      style: GoogleFonts.inter(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF727272),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
              })
        ],
      ),
    );
  }
}
