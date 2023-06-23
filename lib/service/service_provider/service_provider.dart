import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/notification_service.dart';

class SubServiceProviderService {
  Future<void> getSubAdmin(String pincode) async {
    try {
      var response = await FirebaseFirestore.instance.collection("subadmin").get();
      var data = response.docs.toList();


      for (var doc in data) {
        if (doc['pinCode'].first == pincode) {
          NotificationService.instance.sendNotification(doc['fcmToken'], "Your have a new Service request");
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
