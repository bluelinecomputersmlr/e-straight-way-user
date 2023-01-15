import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;

class LocationService {
  Future<Map> updateBusinessLocation(String uid, LatLng position) async {
    final geo = GeoFlutterFire();

    GeoFirePoint location =
        geo.point(latitude: position.latitude, longitude: position.longitude);

    try {
      ///Get users business id
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(uid)
          .get();

      var responseData = response.data();

      var businessId = responseData!["serviceProviderDetails"]["businessUID"];

      ///Update the business location
      await FirebaseFirestore.instance
          .collection("Businesses")
          .doc(businessId)
          .update({"location": location.data});

      return {"status": "success"};
    } catch (e) {
      print(e);

      return {"status": "error"};
    }
  }
}
