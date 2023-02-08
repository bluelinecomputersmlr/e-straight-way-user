import 'package:estraightwayapp/controller/service_provider/my_business_controller.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EditDateBasedBusiness extends StatelessWidget {
  EditDateBasedBusiness({super.key});

  TextEditingController basicServiceChargeController = TextEditingController();

  TextEditingController businesNameController = TextEditingController();

  TextEditingController businesDescriptionontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(MyBusinessController());

    var index = int.parse(Get.parameters["index"].toString());

    basicServiceChargeController.text = businessController.businessData[0]
            ["addedServices"][index]["addedServicePrice"]
        .toString();

    businesNameController.text = businessController.businessData[0]
            ["addedServices"][index]["addedServiceName"]
        .toString();

    businesDescriptionontroller.text = businessController.businessData[0]
            ["addedServices"][index]["addedServiceDescription"]
        .toString();

    return Scaffold(
      backgroundColor: const Color(0xFFCEEED9),
      body: Obx(
        () => Stack(
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
                            "Service Name",
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
                        child: TextFormField(
                          controller: businesNameController,
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
                            "Service Descrption",
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
                        child: TextFormField(
                          controller: businesDescriptionontroller,
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
                        child: TextFormField(
                          controller: basicServiceChargeController,
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

                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  var basicServiceCharge = basicServiceChargeController.text;
                  var businessId =
                      businessController.businessData[0]["uid"].toString();
                  var businessName = businesNameController.text;
                  var businessDescription = businesDescriptionontroller.text;

                  submitBusinesData(
                      context,
                      businessController,
                      basicServiceCharge,
                      businessName,
                      businessDescription,
                      businessId,
                      index);
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
            )
          ],
        ),
      ),
    );
  }
}

Future<void> submitBusinesData(
    BuildContext context,
    MyBusinessController controller,
    String basicServiceCharge,
    String serviceName,
    String serviceDescription,
    String businessId,
    int index) async {
  controller.changeEditButtonText("Saving...");

  List addedService = controller.businessData[0]["addedServices"];

  addedService[index] = {
    "addedServiceDescription": serviceDescription,
    "addedServiceName": serviceName,
    "addedServicePrice": int.parse(basicServiceCharge),
  };

  var data = {"addedServices": addedService};

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
