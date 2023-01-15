import 'package:cloud_functions/cloud_functions.dart';
import 'package:estraightwayapp/service/notification_service.dart';

void sendNotification(
    String userId, String title, String body, bool isBusiness) async {
  //Get the user token using user
  //[isBusiness] is true if we are triggering notififcation to service provider
  //[isBusiness] is false if we ar triggering notification to user
  var userData =
      await NotificatioService().getUserNotificationToken(isBusiness, userId);

  if (userData["status"] == "success") {
    var token = userData["data"][0]["token"];
    try {
      var func = FirebaseFunctions.instance.httpsCallable("notifySubscribers");
      var res = await func.call(<String, dynamic>{
        "targetDevices": [token],
        "messageTitle": title,
        "messageBody": body,
      });
      print(res);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
    }
  }
}
