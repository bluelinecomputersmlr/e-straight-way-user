import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'categories_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  String? photoUrl;
  String? name;
  String? uid;

  CategoryModel({this.name, this.photoUrl, this.uid});
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
