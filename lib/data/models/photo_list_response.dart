import 'photo_model.dart';

class PhotoListResponse {
  final List<PhotoModel> photos;

  PhotoListResponse({
    required this.photos,
  });

  factory PhotoListResponse.fromJson(List array) {
    var photos = <PhotoModel>[];
    for (final photoJson in array) {
      photos.add(PhotoModel.fromJson(photoJson));
    }
    return PhotoListResponse(photos: photos);
  }
}
