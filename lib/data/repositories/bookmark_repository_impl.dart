import 'package:gallery_app_flutter/data/models/bookmark_model.dart';
import 'package:gallery_app_flutter/data/providers/local_storage_provider.dart';
import 'package:gallery_app_flutter/domain/entities/bookmark_entity.dart';
import 'package:gallery_app_flutter/domain/repositories/bookmark_repository.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  final LocalStorageProvider lsProvider;

  BookmarkRepositoryImpl({
    required this.lsProvider,
  });

  @override
  Future<bool> addBookmark({required BookmarkEntity bookmark}) {
    var bookmarkModel = BookmarkModel(
        id: bookmark.id,
        title: bookmark.title,
        thumbnailUrl: bookmark.thumbnailUrl,
        imageUrl: bookmark.imageUrl,
        timestamp: DateTime.now().millisecondsSinceEpoch);
    return lsProvider.addBookmark(bookmarkModel);
  }

  @override
  Future<List<BookmarkEntity>> getBookmarkPhotos(
      {required int startIndex, required int limit}) async {
    try {
      var results =
          await lsProvider.getBookmarks(offset: startIndex, limit: limit);
      return results.map((e) => BookmarkEntity.fromModel(e)).toList();
    } catch (e) {
      throw Exception('Data error');
    }
  }

  @override
  Future<bool> isBookmarked({required int bookmarkId}) {
    return lsProvider.isBookmark(bookmarkId);
  }

  @override
  Future<bool> removeAllBookmark() {
    return Future.value(false);
  }

  @override
  Future<bool> removeBookmark({required int bookmarkId}) {
    return lsProvider.removeBookmark(bookmarkId);
  }
}
