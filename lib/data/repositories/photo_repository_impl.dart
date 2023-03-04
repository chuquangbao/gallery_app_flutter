import 'package:gallery_app_flutter/data/providers/photo_provider.dart';
import 'package:gallery_app_flutter/data/repositories/photo_local_datasource.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoProvider photoProvider;
  final PhotoLocalDataSource localDataSource;

  PhotoRepositoryImpl({
    required this.photoProvider,
    required this.localDataSource,
  });
  @override
  Future<List<PhotoEntity>> getPhotosByPage(
      {required int page, required int limit}) async {
    try {
      var photos = await photoProvider.getPhotosByPage(page, limit);
      var result = photos.map((e) => PhotoEntity.fromModel(e)).toList();
      return result;
    } catch (e) {
      // Load cached photos if load first page
      if (page == 0) {
        final cachedPhotos = await localDataSource.getCachedPhotos();
        var result = cachedPhotos.map((e) => PhotoEntity.fromModel(e)).toList();
        return result;
      }
      throw Exception('Failed to get photos by page: $e');
    }
  }
}
