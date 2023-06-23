import 'dart:convert';

List<SosModel> sosModelFromJson(String str) => List<SosModel>.from(json.decode(str).map((x) => SosModel.fromJson(x)));

String sosModelToJson(List<SosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SosModel {
  String? bookingsId;
  String? businessId;
  String? businessName;
  String? businessContactNumber;
  String? userId;
  String? userName;
  String? phoneNumber;
  String? sosDate;

  SosModel({
    this.bookingsId,
    this.businessId,
    this.businessName,
    this.businessContactNumber,
    this.userId,
    this.userName,
    this.phoneNumber,
    this.sosDate,
  });

  factory SosModel.fromJson(Map<String, dynamic> json) => SosModel(
    bookingsId: json["bookingsId"],
    businessId: json["businessId"],
    businessName: json["businessName"],
    businessContactNumber: json["businessContactNumber"],
    userId: json["userId"],
    userName: json["userName"],
    phoneNumber: json["phoneNumber"],
    sosDate: json["sosDate"],
  );

  Map<String, dynamic> toJson() => {
    "bookingsId": bookingsId,
    "businessId": businessId,
    "businessName": businessName,
    "businessContactNumber": businessContactNumber,
    "userId": userId,
    "userName": userName,
    "phoneNumber": phoneNumber,
    "sosDate": sosDate,
  };
}
