import 'package:gallery_app_flutter/domain/entities/bookmark_entity.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';

abstract class BookMarkUseCase {
  Future<List<BookmarkEntity>> getBookmarks(
      {required int startIndex, required int limit});
  Future<bool> addBookmark({required PhotoEntity photoEntity});
  Future<bool> removeBookmark({required int photoId});
  Future<bool> isBookmarked({required int photoId});
}
