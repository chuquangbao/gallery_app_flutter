import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/entities/bookmark_entity.dart';
import 'package:gallery_app_flutter/domain/repositories/bookmark_repository.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase.dart';

class BookmarkUseCaseImpl extends BookMarkUseCase {
  final BookmarkRepository bookmarkRepository;

  BookmarkUseCaseImpl(this.bookmarkRepository);

  @override
  Future<bool> addBookmark({required PhotoEntity photoEntity}) {
    var bookmark = BookmarkEntity(
      id: photoEntity.id,
      title: photoEntity.title,
      thumbnailUrl: photoEntity.thumbnailUrl,
      imageUrl: photoEntity.imageUrl,
    );
    return bookmarkRepository.addBookmark(bookmark: bookmark);
  }

  @override
  Future<List<BookmarkEntity>> getBookmarks(
      {required int startIndex, required int limit}) {
    return bookmarkRepository.getBookmarkPhotos(
        startIndex: startIndex, limit: limit);
  }

  @override
  Future<bool> isBookmarked({required int photoId}) {
    return bookmarkRepository.isBookmarked(bookmarkId: photoId);
  }

  @override
  Future<bool> removeBookmark({required int photoId}) {
    return bookmarkRepository.removeBookmark(bookmarkId: photoId);
  }
}
