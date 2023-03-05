import 'package:gallery_app_flutter/data/models/bookmark_model.dart';

class BookmarkEntity {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;

  BookmarkEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.imageUrl,
  });

  factory BookmarkEntity.fromModel(BookmarkModel photoModel) {
    return BookmarkEntity(
      id: photoModel.id,
      title: photoModel.title,
      thumbnailUrl: photoModel.thumbnailUrl,
      imageUrl: photoModel.imageUrl,
    );
  }
  factory BookmarkEntity.fromJson(Map<String, dynamic> json) {
    return BookmarkEntity(
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
