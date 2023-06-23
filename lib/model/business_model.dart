import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_model.g.dart';

@JsonSerializable()
class BusinessModel {
  String? uid;
  String? address;
  String? businessName;
  String? businessHours;
  String? businessImage;
  String? categoryUID;
  String? subCategoryUID;
  String? description;
  String? gmapsLink;
  String? phoneNumber;
  @JsonKey(
    fromJson: firestoreTimestampFromJson,
    toJson: firestoreTimestampToJson,
  )
  Timestamp? creationTime;
  double? rating;
  double? serviceCharge;
  double? tokenAdvance;
  List<String>? serviceImages;
  String? subCategoryType;
  String? experience;
  String? vehicleRegistrationNo;
  List<Map<String, dynamic>>? addedServices;
  Map<String, dynamic>? location;
  String? businessFcmToken;
  String? userUid;
  bool? isInitialPaymentDone;

  BusinessModel({
    this.uid,
    this.address,
    this.businessName,
    this.businessHours,
    this.businessImage,
    this.categoryUID,
    this.subCategoryUID,
    this.description,
    this.gmapsLink,
    this.phoneNumber,
    this.userUid,
    this.serviceCharge,
    this.creationTime,
    this.rating,
    this.serviceImages,
    this.subCategoryType,
    this.experience,
    this.vehicleRegistrationNo,
    this.addedServices,
    this.location,
    this.businessFcmToken,
    this.isInitialPaymentDone,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);

  static GeoPoint? _fromJsonGeoPoint(GeoPoint? geoPoint) {
    return geoPoint;
  }

  static GeoPoint? _toJsonGeoPoint(GeoPoint? geoPoint) {
    return geoPoint;
  }
}

@JsonSerializable()
class AddedServiceModelList {
  final List<AddedServiceModel>? addedServices;
  AddedServiceModelList({this.addedServices});
  factory AddedServiceModelList.fromJson(json) =>
      _$AddedServiceModelListFromJson({'addedServices': json});
  List toJson() => _$AddedServiceModelListToJson(this)['addedServices'];
}

@JsonSerializable()
class AddedServiceModel {
  String? addedServiceName;
  double? addedServicePrice;
  String? addedServiceDescription;

  AddedServiceModel({
    this.addedServiceName,
    this.addedServiceDescription,
    this.addedServicePrice,
  });

  factory AddedServiceModel.fromJson(Map<String, dynamic> json) =>
      _$AddedServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddedServiceModelToJson(this);
}
