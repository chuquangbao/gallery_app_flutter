import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PhotoModel {
  final int id;
  final String author;
  final String url;

  PhotoModel({
    required this.id,
    required this.author,
    required this.url,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      author: json['author'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'url': url,
    };
  }
}
