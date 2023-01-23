import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      var today = DateTime.now();
      var endDate = DateTime(
        orderData["bookedDate"].year,
        orderData["bookedDate"].month,
        orderData["bookedDate"].day,
        23,
        59,
        59,
      );

      var response = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("bookedDate", isLessThanOrEqualTo: endDate)
          .where("businessId", isEqualTo: orderData["businessId"])
          .where("serviceName", isEqualTo: orderData["serviceName"])
          .where("isCompleted", isEqualTo: false)
          .get();

      if (response.size > 0) {
        return {"status": "error", "message": "Service is already booked!"};
      }
      await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(orderData["id"])
          .set(orderData, SetOptions(merge: true));
      return {
        "status": "success",
      };
    } catch (e) {
      print(e);

      return {"status": "error", "message": "Unable to place the order"};
    }
  }

  Future<Map> getBookedService() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("bookedDate")
          .get();

      var data = response.docs.toList();

      var responseData = [];

      for (var doc in data) {
        responseData.add(doc.data());
      }

      return {"status": "success", "data": responseData};
    } catch (e) {
      print(e);

      return {"status": "error", "message": "Unable to get the booked service"};
    }
  }

  Stream<List?> getBookingsStream() async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("bookedDate")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      yield null;
    }
  }

  Stream<List?> getBookingsStreamServiceProvider() async* {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId = response.data()!["businessUID"];
      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: false)
          .orderBy("bookedDate")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      yield null;
    }
  }

  Future<void> updateBookingsData(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(id)
          .update(data);
    } catch (e) {
      print(e);
    }
  }
}
