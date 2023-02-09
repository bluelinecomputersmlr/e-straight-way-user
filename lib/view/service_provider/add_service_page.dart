import 'package:estraightwayapp/controller/service_provider/my_business_controller.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddServicePage extends StatelessWidget {
  AddServicePage({super.key});

  final serviceNameController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  final servicePriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(MyBusinessController());

    var size = MediaQuery.of(context).size;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Service Name",
              style: GoogleFonts.inter(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: serviceNameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: GoogleFonts.inter(fontSize: 16.0),
                cursorColor: Colors.black,
                cursorHeight: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Service Description",
              style: GoogleFonts.inter(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: serviceDescriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: GoogleFonts.inter(fontSize: 16.0),
                cursorColor: Colors.black,
                cursorHeight: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Service Price",
              style: GoogleFonts.inter(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: servicePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: GoogleFonts.inter(fontSize: 16.0),
                cursorColor: Colors.black,
                cursorHeight: 20.0,
              ),
            ),
          ),

          const SizedBox(
            height: 30.0,
          ),

          Obx(
            () => Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  var serviceName = serviceNameController.text;
                  var serviceDescription = serviceDescriptionController.text;
                  var servicePrice = servicePriceController.text;

                  if (serviceName.isEmpty ||
                      serviceDescription.isEmpty ||
                      servicePrice.isEmpty) {
                    final snackBar = SnackBar(
                      content: const Text(
                        "Please enter all details",
                      ),
                      action: SnackBarAction(
                        label: 'Okay',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    _submitService(serviceName, serviceDescription,
                        int.parse(servicePrice), businessController, context);
                  }
                },
                child: Container(
                  height: 45.0,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: Text(
                      businessController.addNewServiceButtonText.value,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
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

void _submitService(
    String serviceName,
    String serviceDescription,
    int servicePrice,
    MyBusinessController controller,
    BuildContext context) async {
  controller.toggleAddServiceButton("Adding ...");
  var data = {
    "addedServiceDescription": serviceDescription,
    "addedServiceName": serviceName,
    "addedServicePrice": servicePrice
  };

  var oldData = controller.businessData[0]["addedServices"];

  var newData = [...oldData, data];

  var response = await BusinessServices().updateBusinessData(
      controller.businessId.value, {"addedServices": newData});

  if (response["status"] == "success") {
    final snackBar = SnackBar(
      content: const Text(
        "Service Added Successfully!",
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
        "Unable to add service, please try again!",
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Get.back();
  controller.getBusinessData();
  controller.toggleAddServiceButton("Add Service");
}
