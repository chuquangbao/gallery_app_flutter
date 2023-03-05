import 'package:gallery_app_flutter/domain/entities/bookmark_entity.dart';

abstract class BookmarkRepository {
  Future<List<BookmarkEntity>> getBookmarkPhotos(
      {required int startIndex, required int limit});
  Future<bool> addBookmark({required BookmarkEntity bookmark});
  Future<bool> removeBookmark({required int bookmarkId});
  Future<bool> isBookmarked({required int bookmarkId});
  Future<bool> removeAllBookmark();
}
