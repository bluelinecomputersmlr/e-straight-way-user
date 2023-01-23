import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificatioService {
  Future<Map> getUserNotificationToken(bool isBusiness, String id) async {
    try {
      var userData;
      if (isBusiness) {
        var response = await FirebaseFirestore.instance
            .collection("straightWayUsers")
            .where("serviceProviderDetails.businessUID", isEqualTo: id)
            .get();

        var data = response.docs.toList();

        var responseData = [];

        for (var doc in data) {
          responseData.add(doc.data());
        }

        userData = responseData[0];
      } else {
        var response = await FirebaseFirestore.instance
            .collection("straightWayUsers")
            .doc(id)
            .get();

        userData = response.data();
      }

      print(userData);

      return {"status": "success", "data": userData};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }
}
