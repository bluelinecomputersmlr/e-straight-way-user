import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Future<Map> getReferalData(String referalCode) async {
    try {
      var refererData = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .where("referCode", isEqualTo: referalCode)
          .get();

      if (refererData.size > 0) {
        var data = refererData.docs.toList();

        var responseData = [];

        for (var doc in data) {
          responseData.add(doc.data());
        }
        return {"status": "success", "data": responseData};
      } else {
        return {"status": "error", "message": "Invalid code"};
      }
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }

  Future<Map> updateUserData(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(id)
          .update(data);

      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }
}
