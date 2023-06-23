import 'package:estraightwayapp/controller/home/home_service_provider_contoller.dart';
import 'package:estraightwayapp/controller/service_provider/new_booking_controller.dart';
import 'package:estraightwayapp/helper/send_notification.dart';
import 'package:estraightwayapp/model/sos_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/view/auth/sos_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SosRequestScreen extends StatelessWidget {
  const SosRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Current screen --> $runtimeType');
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
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
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
            "Sos Requests",
            style: GoogleFonts.inter(fontSize: 22.0, fontWeight: FontWeight.w500, color: const Color(0xFF727272)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),

          StreamBuilder<List<SosModel>>(
            stream: SosService.newSosRequest(),
            builder: (context, AsyncSnapshot<List<SosModel>> snapshot) {
              return (!snapshot.hasData)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'User',
                                            style: GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        Text(
                                          snapshot.data![index].userName ?? '',
                                          style: GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          snapshot.data![index].phoneNumber ?? '',
                                          style: GoogleFonts.inter(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF727272),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Service provider',
                                            style: GoogleFonts.inter(fontSize: 18.0, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        // if (snapshot.data![index].businessName != null && snapshot.data![index].businessName!.isNotEmpty) ...[
                                        Text(
                                          snapshot.data![index].businessName ?? '',
                                          style: GoogleFonts.inter(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF727272),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        // ],
                                        Text(
                                          snapshot.data![index].businessContactNumber ?? '',
                                          style: GoogleFonts.inter(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF727272),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              Text(
                                'Sos date : ${DateFormat('dd/MM/yyyy hh:mm:ss a').format(DateTime.parse(snapshot.data![index].sosDate ?? ''))}',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF727272),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemCount: snapshot.data!.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
