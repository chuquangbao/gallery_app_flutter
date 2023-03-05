import 'package:flutter/material.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase_impl.dart';
import 'package:gallery_app_flutter/presentation/controllers/notification_manager.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  final BookMarkUseCase bookMarkUseCase = Get.find<BookmarkUseCaseImpl>();
  var isBookMark = false.obs;
  PhotoController();

  void updateBookmark(int photoId) async {
    var result = await bookMarkUseCase.isBookmarked(photoId: photoId);
    isBookMark.value = result;
    isBookMark.refresh();
  }

  void onBookMarkPressed(PhotoEntity photoEntity) async {
    if (isBookMark.value == true) {
      var result =
          await bookMarkUseCase.removeBookmark(photoId: photoEntity.id);
      isBookMark.value = !result;
      isBookMark.refresh();
      NotificationManager.center.notifyBookmarksListeners();
    } else {
      var result = await bookMarkUseCase.addBookmark(photoEntity: photoEntity);
      isBookMark.value = result;
      isBookMark.refresh();
      NotificationManager.center.notifyBookmarksListeners();
    }
  }
}
