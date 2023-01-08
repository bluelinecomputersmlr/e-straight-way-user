import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderService {
  Future<Map> getBusiness(String uid) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("Businesses")
          .where('uid', isEqualTo: uid)
          .get();
      var data = response.docs.toList();

      var responseData = [];

      for (var doc in data) {
        responseData.add(doc.data());
      }
      return {"status": "success", "data": responseData};
    } catch (e) {
      print(e);

      return {"status": "error"};
    }
  }
}
