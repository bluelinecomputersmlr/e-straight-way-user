// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  String businessContactNumber;
  String businessId;
  String businessName;
  String businessImage;
  String phoneNumber;
  String userName;
  DateTime acceptedDate;
  String userId;
  num rating;
  bool isCancelled = false;
  bool isOrderCompleted = false;
  bool isServiceProviderAccepted = false;
  bool isCompleted = false;

  BookingModel({
    required this.businessContactNumber,
    required this.businessId,
    required this.businessName,
    required this.businessImage,
    required this.phoneNumber,
    required this.userName,
    required this.acceptedDate,
    required this.userId,
    this.rating = 0,
    required this.isCancelled,
    required this.isOrderCompleted,
    required this.isServiceProviderAccepted,
    required this.isCompleted,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        businessContactNumber: json["businessContactNumber"],
        businessId: json["businessId"],
        businessName: json["businessName"],
        businessImage: json["businessImage"],
        phoneNumber: json["phoneNumber"],
        userName: json["userName"],
        acceptedDate: json["acceptedDate"] == null
            ? DateTime.now()
            : (json["acceptedDate"] as Timestamp).toDate(),
        userId: json["userId"],
        rating: json["rating"],
        isCancelled: json["isCancelled"] ?? false,
        isOrderCompleted: json["isOrderCompleted"] ?? false,
        isCompleted: json["isCompleted"] ?? false,
        isServiceProviderAccepted: json["isServiceProviderAccepted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "businessContactNumber": businessContactNumber,
        "id": userId,
        "businessId": businessId,
        "businessName": businessName,
        "businessImage": businessImage,
        "phoneNumber": phoneNumber,
        "acceptedDate": Timestamp.fromDate(acceptedDate),
        "userId": userId,
        "rating": rating,
        "isCancelled": isCancelled,
        "isOrderCompleted": isOrderCompleted,
        "isCompleted": isCompleted,
        "isServiceProviderAccepted": isServiceProviderAccepted,
      };
}
