import 'package:cloud_firestore/cloud_firestore.dart';

class NotificatioService {
  Future<Map> getUserNotificationToken(bool isBusiness, String id) async {
    try {
      var response;
      if (isBusiness) {
        response = await FirebaseFirestore.instance
            .collection("Businesses")
            .doc(id)
            .get();
      } else {
        response = await FirebaseFirestore.instance
            .collection("straightWayUsers")
            .doc(id)
            .get();
      }

      return {"status": "success", "data": response.data()};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }
}
