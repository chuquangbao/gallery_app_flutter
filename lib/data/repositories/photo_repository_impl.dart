import 'package:gallery_app_flutter/data/models/photo_model.dart';
import 'package:gallery_app_flutter/data/providers/photo_provider.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';

import 'photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoProvider photoProvider;

  PhotoRepositoryImpl({required this.photoProvider});

  @override
  Future<List<PhotoEntity>> getPhotos() async {
    try {
      var photosResponse = await photoProvider.getPhotos();
      var result = photosResponse.map((e) => PhotoEntity.fromModel(e)).toList();
      return result;
    } catch (e) {
      throw Exception('Failed to get photos: $e');
    }
  }

  @override
  Future<List<PhotoEntity>> getPhotosByPage(
      {required int page, required int limit}) async {
    try {
      var response = await photoProvider.getPhotosByPage(page, limit);
      var result =
          response.photos.map((e) => PhotoEntity.fromModel(e)).toList();
      return result;
    } catch (e) {
      throw Exception('Failed to get photos by page: $e');
    }
  }
}
