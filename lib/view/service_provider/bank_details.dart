import 'package:estraightwayapp/controller/home/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var profilePageController = Get.put(ProfilePageController());
    return Scaffold(
      backgroundColor: const Color(0xFFCEEED9),
      body: Obx(
        () => ListView(
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
              "Bank Details",
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

            (profilePageController.isLoading.value)
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              profilePageController.userData.value.userName
                                  .toString(),
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.7,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "Bank Name: ${profilePageController.userData.value.serviceProviderDetails!.bankName.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "Account Holder's Name: ${profilePageController.userData.value.serviceProviderDetails!.bankAccountName.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "Account Number: ${profilePageController.userData.value.serviceProviderDetails!.bankAccountNumber.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "IFSC Code : ${profilePageController.userData.value.serviceProviderDetails!.bankAccountNumber.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "UPI Number : ${profilePageController.userData.value.serviceProviderDetails!.bankAccountNumber.toString()}",
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/signUpServiceProvider");
        },
      ),
    );
  }
}
