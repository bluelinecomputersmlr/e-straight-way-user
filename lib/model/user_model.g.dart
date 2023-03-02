// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      userName: json['userName'] as String?,
      lastOpenDate: firestoreTimestampFromJson(json['lastOpenDate']),
      createdDate: firestoreTimestampFromJson(json['createdDate']),
      phoneNumber: json['phoneNumber'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      isServiceProvider: json['isServiceProvider'] as bool?,
      isServiceProviderRegistered: json['isServiceProviderRegistered'] as bool?,
      isInitialPaymentDone: json['isInitialPaymentDone'] as bool?,
      lastLoggedAsUser: json['lastLoggedAsUser'] as bool?,
      serviceProviderDetails: json['serviceProviderDetails'] == null
          ? null
          : ServiceProviderModel.fromJson(
              json['serviceProviderDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'lastOpenDate': firestoreTimestampToJson(instance.lastOpenDate),
      'createdDate': firestoreTimestampToJson(instance.createdDate),
      'phoneNumber': instance.phoneNumber,
      'profilePhoto': instance.profilePhoto,
      'isServiceProvider': instance.isServiceProvider,
      'isServiceProviderRegistered': instance.isServiceProviderRegistered,
      'lastLoggedAsUser': instance.lastLoggedAsUser,
      'isInitialPaymentDone': instance.isInitialPaymentDone,
      'serviceProviderDetails': instance.serviceProviderDetails?.toJson(),
    };

ServiceProviderModel _$ServiceProviderModelFromJson(
        Map<String, dynamic> json) =>
    ServiceProviderModel(
      serviceProviderCategory: json['serviceProviderCategory'] as String?,
      serviceProviderCategoryUID: json['serviceProviderCategoryUID'] as String?,
      serviceProviderSubCategory: json['serviceProviderSubCategory'] as String?,
      serviceProviderSubCategoryUID:
          json['serviceProviderSubCategoryUID'] as String?,
      businessUID: json['businessUID'] as String?,
      businessType: json['businessType'] as String?,
      userAddress: json['userAddress'] as String?,
      bankName: json['bankName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      bankAccountName: json['bankAccountName'] as String?,
      ifscCode: json['ifscCode'] as String?,
      aadharDocument: json['aadharDocument'] as String?,
      drivingLicenceDocument: json['drivingLicenceDocument'] as String?,
      vehicleRegistrationDocument:
          json['vehicleRegistrationDocument'] as String?,
    );

Map<String, dynamic> _$ServiceProviderModelToJson(
        ServiceProviderModel instance) =>
    <String, dynamic>{
      'serviceProviderCategory': instance.serviceProviderCategory,
      'serviceProviderCategoryUID': instance.serviceProviderCategoryUID,
      'serviceProviderSubCategory': instance.serviceProviderSubCategory,
      'serviceProviderSubCategoryUID': instance.serviceProviderSubCategoryUID,
      'businessUID': instance.businessUID,
      'businessType': instance.businessType,
      'userAddress': instance.userAddress,
      'bankName': instance.bankName,
      'bankAccountNumber': instance.bankAccountNumber,
      'bankAccountName': instance.bankAccountName,
      'ifscCode': instance.ifscCode,
      'aadharDocument': instance.aadharDocument,
      'drivingLicenceDocument': instance.drivingLicenceDocument,
      'vehicleRegistrationDocument': instance.vehicleRegistrationDocument,
    };
