class Course {
  String? sId;
  String? name;
  String? description;
  String? thumbnailUrl;
  String? insideThumbnailUrl;
  String? videoUrl;
  String? category;
  String? createdDate;
  int? iV;
  String? id;

  Course(
      {this.sId,
      this.name,
      this.description,
      this.thumbnailUrl,
      this.insideThumbnailUrl,
      this.videoUrl,
      this.category,
      this.createdDate,
      this.iV,
      this.id});

  Course.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    thumbnailUrl = json['thumbnailUrl'];
    insideThumbnailUrl = json['insideThumbnailUrl'];
    videoUrl = json['videoUrl'];
    category = json['category'];
    createdDate = json['createdDate'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['thumbnailUrl'] = thumbnailUrl;
    data['insideThumbnailUrl'] = insideThumbnailUrl;
    data['videoUrl'] = videoUrl;
    data['category'] = category;
    data['createdDate'] = createdDate;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}
