// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      uid: json['uid'] as String?,
      address: json['address'] as String?,
      businessName: json['businessName'] as String?,
      businessHours: json['businessHours'] as String?,
      businessImage: json['businessImage'] as String?,
      categoryUID: json['categoryUID'] as String?,
      subCategoryUID: json['subCategoryUID'] as String?,
      description: json['description'] as String?,
      gmapsLink: json['gmapsLink'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      serviceCharge: (json['serviceCharge'] as num?)?.toDouble(),
      creationTime: firestoreTimestampFromJson(json['creationTime']),
      rating: (json['rating'] as num?)?.toDouble(),
      serviceImages: (json['serviceImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategoryType: json['subCategoryType'] as String?,
      experience: json['experience'] as String?,
      vehicleRegistrationNo: json['vehicleRegistrationNo'] as String?,
      addedServices: (json['addedServices'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'address': instance.address,
      'businessName': instance.businessName,
      'businessHours': instance.businessHours,
      'businessImage': instance.businessImage,
      'categoryUID': instance.categoryUID,
      'subCategoryUID': instance.subCategoryUID,
      'description': instance.description,
      'gmapsLink': instance.gmapsLink,
      'phoneNumber': instance.phoneNumber,
      'creationTime': firestoreTimestampToJson(instance.creationTime),
      'rating': instance.rating,
      'serviceCharge': instance.serviceCharge,
      'serviceImages': instance.serviceImages,
      'subCategoryType': instance.subCategoryType,
      'experience': instance.experience,
      'vehicleRegistrationNo': instance.vehicleRegistrationNo,
      'addedServices': instance.addedServices,
    };

AddedServiceModelList _$AddedServiceModelListFromJson(
        Map<String, dynamic> json) =>
    AddedServiceModelList(
      addedServices: (json['addedServices'] as List<dynamic>?)
          ?.map((e) => AddedServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddedServiceModelListToJson(
        AddedServiceModelList instance) =>
    <String, dynamic>{
      'addedServices': instance.addedServices,
    };

AddedServiceModel _$AddedServiceModelFromJson(Map<String, dynamic> json) =>
    AddedServiceModel(
      addedServiceName: json['addedServiceName'] as String?,
      addedServiceDescription: json['addedServiceDescription'] as String?,
      addedServicePrice: (json['addedServicePrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddedServiceModelToJson(AddedServiceModel instance) =>
    <String, dynamic>{
      'addedServiceName': instance.addedServiceName,
      'addedServicePrice': instance.addedServicePrice,
      'addedServiceDescription': instance.addedServiceDescription,
    };
