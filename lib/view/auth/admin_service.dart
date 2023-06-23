import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  static CollectionReference adminService = FirebaseFirestore.instance.collection('admin');

  static Future<String?> getAdmins() async {
    try {
      QuerySnapshot querySnapshot = await adminService.get();
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> map = querySnapshot.docs[0].data() as Map<String, dynamic>;
        return map['token'];
      }
      return null;
    } on FirebaseException catch (e) {
      print('Catch error in Get Current User : ${e.message}');
      return null;
    }
  }
}