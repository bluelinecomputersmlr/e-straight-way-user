import 'package:estraightwayapp/controller/service_provider/received_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodaysConfirmedOrders extends StatelessWidget {
  const TodaysConfirmedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    var receivedBookingsController = Get.put(ReceivedBookingController());
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
            "Today's Confimed Orders",
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
            stream:
                receivedBookingsController.getTodaysAcceptedBookingsStream(),
            builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
              return (!snapshot.hasData)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
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
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                snapshot.data![index]["businessName"]
                                    .toString(),
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
                              const SizedBox(
                                height: 20.0,
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
                                    DateFormat().add_jm().format(
                                          snapshot.data![index]["bookedDate"]
                                              .toDate(),
                                        ),
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
            },
          )
        ],
      ),
    );
  }
}
