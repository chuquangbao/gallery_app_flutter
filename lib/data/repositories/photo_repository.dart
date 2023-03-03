import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<List<PhotoEntity>> getPhotos();
  Future<List<PhotoEntity>> getPhotosByPage(
      {required int page, required int limit});
}
