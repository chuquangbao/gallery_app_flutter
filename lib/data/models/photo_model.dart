import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PhotoModel {
  final int id;
  final String title;
  final int albumId;
  final String url;
  final String thumbnailUrl;

  PhotoModel({
    required this.id,
    required this.title,
    required this.albumId,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      title: json['title'],
      albumId: json['albumId'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': title,
      'albumId': albumId,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
