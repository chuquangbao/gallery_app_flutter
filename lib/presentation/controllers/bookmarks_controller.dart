import 'package:flutter/material.dart';
import 'package:gallery_app_flutter/domain/entities/bookmark_entity.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase_impl.dart';
import 'package:gallery_app_flutter/presentation/controllers/notification_manager.dart';
import 'package:gallery_app_flutter/presentation/navigations/app_routes.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  final BookMarkUseCase bookmarkUseCase = Get.find<BookmarkUseCaseImpl>();
  final scrollController = ScrollController();

  final bookmarks = <BookmarkEntity>[].obs;
  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final isCanLoadMore = true.obs;

  final limitPage = 30;

  BookmarkController();

  @override
  void onInit() {
    super.onInit();
    loadPhotos();
    scrollController.addListener(_scrollListener);
    NotificationManager.center.bookmarksChanges.addListener(_bookmarksChanged);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();

    NotificationManager.center.bookmarksChanges
        .removeListener(_bookmarksChanged);

    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 200 &&
        !scrollController.position.outOfRange &&
        !isLoadingMore.value &&
        !isLoading.value) {
      _fetchMorePhotos();
    }
  }

  void _bookmarksChanged() {
    loadPhotos();
  }

  void loadPhotos() async {
    try {
      isLoading(true);
      final result =
          await bookmarkUseCase.getBookmarks(startIndex: 0, limit: limitPage);
      bookmarks.value = [];
      bookmarks.addAll(result);
      isLoading(false);
      bookmarks.refresh();
    } catch (e) {
      isLoading(false);
      bookmarks.refresh();
    }
  }

  void _fetchMorePhotos() async {
    var loadingPage = bookmarks.length;
    isLoadingMore.value = true;
    final result = await bookmarkUseCase.getBookmarks(
        startIndex: loadingPage, limit: limitPage);
    if (result.length < limitPage) {
      isCanLoadMore.value = false;
    }
    bookmarks.addAll(result);
    isLoadingMore.value = false;
    bookmarks.refresh();
  }

  void onPhotoSelected(int index) {
    var item = bookmarks[index];
    var photoEntity = PhotoEntity(
        id: item.id,
        title: item.title,
        thumbnailUrl: item.thumbnailUrl,
        imageUrl: item.imageUrl);

    Get.toNamed(AppRoutes.photoView, arguments: photoEntity);
  }

  bool get isNoData {
    return bookmarks.isEmpty && isLoading.value == false;
  }
}
