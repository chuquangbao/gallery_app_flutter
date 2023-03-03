import 'photo_model.dart';

class PhotoListResponse {
  final List<PhotoModel> photos;

  PhotoListResponse({
    required this.photos,
  });

  factory PhotoListResponse.fromJson(Map<String, dynamic> json) {
    var photos = <PhotoModel>[];

    if (json['photos'] != null) {
      for (final photoJson in json['photos']) {
        photos.add(PhotoModel.fromJson(photoJson));
      }
    }
    return PhotoListResponse(photos: photos);
  }
}
