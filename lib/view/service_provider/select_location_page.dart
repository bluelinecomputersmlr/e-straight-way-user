import 'dart:developer';

import 'package:estraightwayapp/controller/service_provider/select_location_controller.dart';
import 'package:estraightwayapp/service/service_provider/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var selectLocationController = Get.put(SelectLocationController());
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: selectLocationController.initalMapCameraPosition.value,
                zoom: 30.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                selectLocationController.mapController.complete(controller);
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: selectLocationController.markers.values.toSet(),
              onTap: (argument) {
                selectLocationController.selectPlace(argument);
              },
              zoomControlsEnabled: false,
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 80.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pick your location",
                      style: GoogleFonts.inter(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectLocationController.position.value ==
                const LatLng(37.42796133580664, -122.085749655962)) {
              final snackBar = SnackBar(
                content: const Text(
                  'Please select your location',
                ),
                action: SnackBarAction(
                  label: 'Okay',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              updateLocation(selectLocationController, context);
            }
          },
          backgroundColor: const Color(0xFF3F5C9F),
          child: (selectLocationController.isLoading.value)
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(
                  Icons.send_rounded,
                ),
        ),
      ),
    );
  }
}

void updateLocation(
    SelectLocationController controller, BuildContext context) async {
  controller.toggleLoading(true);
  var response = await LocationService().updateBusinessLocation(
      FirebaseAuth.instance.currentUser!.uid, controller.position.value);
log("----data--- $response");
  if (response["status"] == "success") {
log("----data--- $response");
    Get.toNamed("/homeServiceProviderPage");
  } else {
    final snackBar = SnackBar(
      content: const Text(
        'Unable to set the location',
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  controller.toggleLoading(false);
}
