import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SelectLocationController extends GetxController {
  Rx<LatLng> initalMapCameraPosition =
      // ignore: prefer_const_constructors
      LatLng(37.42796133580664, -122.085749655962).obs;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getLocationAndCreateMap();
  }

  void getLocationAndCreateMap() async {
    Location location = Location();

    bool serviceEnabled = false;
    PermissionStatus permissionGranted;
    LocationData locationData;

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    var longitude = locationData.longitude!;
    var latitude = locationData.latitude!;

    initalMapCameraPosition.value = LatLng(
      latitude,
      longitude,
    );

    final GoogleMapController controller = await mapController.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        latitude,
        longitude,
      ),
      zoom: 14.4746,
    )));
  }

  void selectPlace(LatLng position) {
    markers.value = {};
    var marker = Marker(
      markerId: MarkerId('${position.latitude}-${position.longitude}'),
      position: position,
    );

    markers[MarkerId('${position.latitude}-${position.longitude}')] = marker;
  }
}
