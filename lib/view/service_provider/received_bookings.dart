import 'dart:developer';

import 'package:estraightwayapp/controller/service_provider/received_booking_controller.dart';
import 'package:estraightwayapp/helper/send_notification.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReceivedBookings extends StatefulWidget {
  const ReceivedBookings({super.key});

  @override
  State<ReceivedBookings> createState() => _ReceivedBookingsState();
}

class _ReceivedBookingsState extends State<ReceivedBookings> {
  final receivedBookingsController = Get.put(ReceivedBookingController());

  @override
  void initState() {
    receivedBookingsController.getStraightWayUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.7;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: const Color(0xFFCEEED9),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/icons/wave.png'),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded, size: 30.0, color: Color(0xFF3F5C9F)),
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
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500, color: const Color(0xFF3F5C9F)),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 20.0),
              ],
            ),

            //App Bar Ends Here
            const SizedBox(height: 20.0),
            Text(
              "Received Bookings",
              style: GoogleFonts.inter(fontSize: 22.0, fontWeight: FontWeight.w500, color: const Color(0xFF727272)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),

            Expanded(
              child: StreamBuilder(
                stream: BusinessServices.acceptedBookings(
                  businessId: receivedBookingsController.userModel != null &&
                          receivedBookingsController.userModel!.serviceProviderDetails != null
                      ? receivedBookingsController.userModel!.serviceProviderDetails!.businessUID ?? ''
                      : '',
                ),
                builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
                  return (!snapshot.hasData)
                      ? const Center(child: CircularProgressIndicator())
                      : snapshot.hasData && snapshot.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No bookings found',
                                style: GoogleFonts.inter(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (itemWidth / itemHeight * 0.8),
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
                                        snapshot.data![index]["userName"].toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        snapshot.data![index]["businessName"].toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF727272),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      // Text(
                                      //   snapshot.data![index]["subCategory"].toString(),
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
                                        snapshot.data![index]["phoneNumber"].toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF727272),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(snapshot.data![index]["bookedDate"].toDate()),
                                            style: GoogleFonts.inter(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF727272),
                                            ),
                                          ),
                                          Text(
                                            DateFormat().add_jm().format(snapshot.data![index]["bookedDate"].toDate()),
                                            style: GoogleFonts.inter(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF727272),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30.0),
                                      (!snapshot.data![index]["isOrderCompleted"])
                                          ? GestureDetector(
                                              onTap: () async {
                                                var bookingId = snapshot.data![index]["id"];
                                                var data = {
                                                  "isCompleted": true,
                                                  "isOrderCompleted": true,
                                                  "completedDate": DateTime.now(),
                                                };
                                                await BusinessServices().updateBookingsData(bookingId, data);
                                                sendNotification(
                                                  snapshot.data![index]["userId"],
                                                  "Your booking request is completed",
                                                  "${snapshot.data![index]["businessName"]} completed your booking",
                                                  false,
                                                );
                                              },
                                              child: Container(
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.green, borderRadius: BorderRadius.circular(20.0)),
                                                child: Center(
                                                  child: Text(
                                                    "Complete Request",
                                                    style: GoogleFonts.inter(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                );
                              },
                            );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
