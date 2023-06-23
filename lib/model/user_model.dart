import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? uid;
  String? userName;
  @JsonKey(
    fromJson: firestoreTimestampFromJson,
    toJson: firestoreTimestampToJson,
  )
  Timestamp? lastOpenDate;
  @JsonKey(
    fromJson: firestoreTimestampFromJson,
    toJson: firestoreTimestampToJson,
  )
  Timestamp? createdDate;
  String? phoneNumber;
  String? profilePhoto;
  bool? isServiceProvider;
  bool? isServiceProviderRegistered;
  bool? lastLoggedAsUser;
  bool? isInitialPaymentDone;
  ServiceProviderModel? serviceProviderDetails;

  UserModel(
      {this.uid,
      this.userName,
      this.lastOpenDate,
      this.createdDate,
      this.phoneNumber,
      this.profilePhoto,
      this.isServiceProvider,
      this.isServiceProviderRegistered,
      this.isInitialPaymentDone,
      this.lastLoggedAsUser,
      this.serviceProviderDetails});
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ServiceProviderModel {
  String? serviceProviderCategory;
  String? serviceProviderCategoryUID;
  String? serviceProviderSubCategory;
  String? serviceProviderSubCategoryUID;
  String? businessUID;
  String? businessType;
  String? userAddress;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountName;
  String? ifscCode;
  String? aadharDocument;
  String? drivingLicenceDocument;
  String? gstNumber;
  String? vehicleRegistrationDocument;
  bool? isInitialPaymentDone;
  ServiceProviderModel(
      {this.serviceProviderCategory,
      this.serviceProviderCategoryUID,
      this.serviceProviderSubCategory,
      this.serviceProviderSubCategoryUID,
      this.businessUID,
      this.businessType,
      this.userAddress,
      this.bankName,
      this.bankAccountNumber,
      this.bankAccountName,
      this.ifscCode,
      this.aadharDocument,
      this.drivingLicenceDocument,
      this.gstNumber,
      this.isInitialPaymentDone,
      this.vehicleRegistrationDocument});
  Map<String, dynamic> toJson() => _$ServiceProviderModelToJson(this);
  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderModelFromJson(json);
}

Timestamp? firestoreTimestampFromJson(dynamic value) {
  return value; //value != null ? Timestamp.fromMicrosecondsSinceEpoch(value) : value;
}

/// This method only stores the "timestamp" data type back in the Firestore
dynamic firestoreTimestampToJson(dynamic value) => value;
