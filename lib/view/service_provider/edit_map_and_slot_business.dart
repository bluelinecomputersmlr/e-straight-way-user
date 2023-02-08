import 'package:estraightwayapp/controller/service_provider/my_business_controller.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EditMapAndSlotBasedBusiness extends StatelessWidget {
  EditMapAndSlotBasedBusiness({super.key});

  TextEditingController basicServiceChargeController = TextEditingController();

  TextEditingController yearOfExperienceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(MyBusinessController());

    if (!businessController.isInitialValueSet.value) {
      basicServiceChargeController.text =
          businessController.businessData[0]["serviceCharge"].toString();
      yearOfExperienceController.text =
          businessController.businessData[0]["experience"].toString();

      businessController.toggleInitialValueStatus(true);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFCEEED9),
      body: Stack(
        children: [
          ListView(
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
                "My Business",
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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Basic Service Charge",
                          style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: basicServiceChargeController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 16.0),
                        // cursorColor: Colors.black,
                        // cursorHeight: 20.0,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Years Of Experience",
                          style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: yearOfExperienceController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 16.0),
                        cursorColor: Colors.black,
                        cursorHeight: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  var basicServiceCharge = basicServiceChargeController.text;
                  var yearOfExp = yearOfExperienceController.text;
                  var businessId =
                      businessController.businessData[0]["uid"].toString();

                  if (basicServiceCharge !=
                          businessController.businessData[0]["serviceCharge"]
                              .toString() ||
                      yearOfExp !=
                          businessController.businessData[0]["experience"]
                              .toString()) {
                    submitBusinesData(context, businessController,
                        basicServiceCharge, yearOfExp, businessId);
                  }
                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.40,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: Text(
                      businessController.editBusinessButtonText.value,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

Future<void> submitBusinesData(
    BuildContext context,
    MyBusinessController controller,
    String basicServiceCharge,
    String yearOfExp,
    String businessId) async {
  controller.changeEditButtonText("Saving...");

  var data = {
    "experience": yearOfExp,
    "serviceCharge": int.parse(basicServiceCharge),
  };

  var updateStatus =
      await BusinessServices().updateBusinessData(businessId, data);

  if (updateStatus["status"] == "success") {
    final snackBar = SnackBar(
      content: const Text(
        "Updated Successfully!",
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    final snackBar = SnackBar(
      content: const Text(
        "Unable to update, please try again!",
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  controller.changeEditButtonText("Save");
}
