import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BookmarkModel {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String imageUrl;
  final int timestamp;

  BookmarkModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.timestamp,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'timestamp': timestamp,
    };
  }
}
