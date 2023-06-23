import 'dart:async';

import 'package:estraightwayapp/service/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SelectLocationController extends GetxController {
  Rx<LatLng> initalMapCameraPosition =
      // ignore: prefer_const_constructors
      LatLng(37.42796133580664, -122.085749655962).obs;

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  Rx<LatLng> position = const LatLng(37.42796133580664, -122.085749655962).obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLocationAndCreateMap();
  }

  Future<void> getLocationAndCreateMap() async {
    bool isPermissionGranted = await SagarLocationService.instance.checkLocationPermission();
    print('Current Home isPermissionGranted --> $isPermissionGranted');
    if (!isPermissionGranted) {
      await getLocationAndCreateMap();
    }
    Position currentPosition = await SagarLocationService.instance.getCurrentLocation();
    print('Current Home position --> ${currentPosition.toJson()}');

    var longitude = currentPosition.longitude;
    var latitude = currentPosition.latitude;

    print('getLocationAndCreateMap latlng :: $latitude : $longitude');
    initalMapCameraPosition.value = LatLng(latitude, longitude);

    final GoogleMapController controller = await mapController.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 14.4746)),
    );
  }

  void selectPlace(LatLng currentPosition) {
    markers.value = {};
    position.value = currentPosition;
    var marker = Marker(
      markerId: MarkerId('${currentPosition.latitude}-${currentPosition.longitude}'),
      position: currentPosition,
    );

    markers[MarkerId('${currentPosition.latitude}-${currentPosition.longitude}')] = marker;
  }

  void toggleLoading(bool val) {
    isLoading(val);
  }
}
