import 'package:estraightwayapp/controller/service_provider/select_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var selectLocationController = Get.put(SelectLocationController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: selectLocationController.initalMapCameraPosition.value,
                zoom: 50.4746,
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
                    "Select Location",
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
        onPressed: () {},
        backgroundColor: const Color(0xFF3F5C9F),
        child: const Icon(
          Icons.send_rounded,
        ),
      ),
    );
  }
}
