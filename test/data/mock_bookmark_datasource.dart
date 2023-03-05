import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_app_flutter/data/models/bookmark_model.dart';
import 'package:gallery_app_flutter/data/providers/local_storage_provider.dart';
import 'package:gallery_app_flutter/data/repositories/bookmark_repository_impl.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/repositories/bookmark_repository.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase_impl.dart';
import 'package:mockito/mockito.dart';
// Define a mock for the data source

class MockBookmarkDataSource extends Mock implements LocalStorageProvider {}

void main() {
  group('BookmarkUseCase', () {
    BookMarkUseCase? useCase;
    BookmarkRepository? repository;
    LocalStorageProvider? dataSource;

    // Set up the use case and mock data source before each test
    setUp(() {
      dataSource = LocalStorageProvider();
      repository = BookmarkRepositoryImpl(lsProvider: dataSource!);
      useCase = BookmarkUseCaseImpl(repository!);
    });

    test('addBookmark adds a bookmark to the repository', () async {
      // Arrange
      final bookmark = PhotoEntity(
        id: 1000,
        title: 'test_title',
        imageUrl: 'https://toplist.vn/images/800px/midu-643664.jpg',
        thumbnailUrl: 'https://toplist.vn/images/800px/midu-643664.jpg',
      );

      final photoEntity = BookmarkModel(
          id: 1000,
          title: 'test_title',
          imageUrl: 'https://toplist.vn/images/800px/midu-643664.jpg',
          thumbnailUrl: 'https://toplist.vn/images/800px/midu-643664.jpg',
          timestamp: DateTime.now().millisecondsSinceEpoch);

      // Act
      await useCase?.addBookmark(photoEntity: bookmark);

      // Assert
      verify(dataSource?.addBookmark(photoEntity));
    });

    test('removeBookmark removes a bookmark from the repository', () async {
      // Arrange
      final bookmark = PhotoEntity(
        id: 1000,
        title: 'test_title',
        imageUrl: 'https://toplist.vn/images/800px/midu-643664.jpg',
        thumbnailUrl: 'https://toplist.vn/images/800px/midu-643664.jpg',
      );

      // Act
      await useCase?.removeBookmark(photoId: bookmark.id);

      // Assert
      verify(dataSource?.removeBookmark(bookmark.id));
    });
  });
}
