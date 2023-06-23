import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/bookings_model.dart';
import 'package:estraightwayapp/model/sos_model.dart';

class SosService {
  static CollectionReference sosServices = FirebaseFirestore.instance.collection('Sos');

  static Future<void> createSosRequest(BookingModel bookingModel) async {
    try {
      SosModel sosModel = SosModel(
        phoneNumber: bookingModel.phoneNumber,
        bookingsId: bookingModel.userId,
        businessContactNumber: bookingModel.businessContactNumber,
        businessName: bookingModel.businessName,
        businessId: bookingModel.businessId,
        userId: bookingModel.userId,
        userName: bookingModel.userName,
        sosDate: DateTime.now().toIso8601String(),
      );
      print('SosModel --> ${sosModel.toJson()}');
      await sosServices.doc().set(sosModel.toJson());
    } on FirebaseException catch (e) {
      print('Catch error in createSosRequest : ${e.message}');
    }
  }

  static Stream<List<SosModel>> newSosRequest() {
    return sosServices.orderBy("sosDate", descending: true).snapshots().map(
      (event) {
        return event.docs.map((e) => SosModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      },
    );
  }
}
