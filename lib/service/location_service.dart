// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:geolocator/geolocator.dart';

class SagarLocationService {
  SagarLocationService._privateConstructor();

  static final SagarLocationService instance = SagarLocationService._privateConstructor();
  final GeolocatorPlatform geoLocatorPlatform = GeolocatorPlatform.instance;


  Future<bool> checkLocationService() async {
    bool isServiceAvailable = await geoLocatorPlatform.isLocationServiceEnabled();
    if (!isServiceAvailable) {
      await geoLocatorPlatform.openLocationSettings();
    }
    return isServiceAvailable;
  }

  Future<bool> checkLocationPermission() async {
    bool isServiceAvailable = await checkLocationService();
    print('service --> $isServiceAvailable');
    if (isServiceAvailable) {
      LocationPermission locationPermission = await geoLocatorPlatform.checkPermission();
      print('locationPermission --> $locationPermission');
      switch (locationPermission) {
        case LocationPermission.denied:
          await geoLocatorPlatform.requestPermission();
          return false;
        case LocationPermission.deniedForever:
          await geoLocatorPlatform.requestPermission();
          return false;
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          await getCurrentLocation();
          return true;
        case LocationPermission.unableToDetermine:
          await checkLocationPermission();
          return false;
        default:
          return false;
      }
    }
    return isServiceAvailable;
  }

  Future<Position> getCurrentLocation() async {
    Position position = await GeolocatorPlatform.instance.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation),
    );
    print('message --> ${position.toJson()}');
    return position;
  }

  String calculateDistance(currentLat, currentLon, destinationLat, destinationLon) {
    double p = 0.017453292519943295;
    double Function(num radians) c = cos;
    double a = 0.5 - c((destinationLat - currentLat) * p) / 2 + c(currentLat * p) * c(destinationLat * p) * (1 - c((destinationLon - currentLon) * p)) / 2;
    double distance = 12742 * asin(sqrt(a));
    num totalDistance = num.parse(distance.toString());
    return totalDistance.toStringAsFixed(2);
  }
}
