import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';

class BusinessServices extends GetConnect {
  Stream<List<BusinessModel>?> getBusiness(
      String id, String? subCategoryType) async* {
    try {
      // yield* FirebaseFirestore.instance
      //     .collection("Businesses")
      //     .where('subCategoryUID', isEqualTo: id)
      //     .snapshots()
      //     .map((snapshot) {
      //   return snapshot.docs
      //       .map((doc) => BusinessModel.fromJson(doc.data()))
      //       .toList();
      // });

      final geo = GeoFlutterFire();
      var collectionReference = FirebaseFirestore.instance
          .collection('Businesses')
          .where('subCategoryUID', isEqualTo: id);
      GeoFirePoint center =
          geo.point(latitude: 12.871184881131773, longitude: 74.8443603515625);

      yield* geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: 50.0, field: "location")
          .map((snapshot) {
        return snapshot
            .map((doc) =>
                BusinessModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      yield null;
    }
  }

  // Future<Map> getBusinessData()async{
  //   try {
  //     var response = await
  //   } catch (e) {

  //   }
  // }

  Future<Map> bookService(Map<String, dynamic> orderData) async {
    try {
      await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(orderData["id"])
          .set(orderData, SetOptions(merge: true));
      return {
        "status": "success",
      };
    } catch (e) {
      print(e);

      return {"status": "error"};
    }
  }
}
