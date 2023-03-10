import 'package:gallery_app_flutter/data/models/photo_model.dart';

class PhotoEntity {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;

  PhotoEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.imageUrl,
  });

  factory PhotoEntity.fromModel(PhotoModel photoModel) {
    return PhotoEntity(
      id: photoModel.id,
      title: photoModel.title,
      thumbnailUrl: photoModel.thumbnailUrl,
      imageUrl: photoModel.url,
    );
  }
  factory PhotoEntity.fromJson(Map<String, dynamic> json) {
    return PhotoEntity(
      id: json['id'],
      title: json['title'],
      imageUrl: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': title,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
