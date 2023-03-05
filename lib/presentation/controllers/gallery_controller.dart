import 'package:flutter/material.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/usecases/get_photo_list_usecase.dart';
import 'package:gallery_app_flutter/domain/usecases/get_photo_list_usecase_impl.dart';
import 'package:gallery_app_flutter/presentation/navigations/app_routes.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  final GetPhotoListUseCase getPhotoListUseCase =
      Get.find<GetPhotoListUseCaseImpl>();
  final scrollController = ScrollController();

  final photos = <PhotoEntity>[].obs;
  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final isCanLoadMore = true.obs;

  var currentPage = 0;
  final limitPage = 30;

  GalleryController();

  @override
  void onInit() {
    super.onInit();
    loadPhotos();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
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

  void loadPhotos() async {
    try {
      isLoading(true);
      final result =
          await getPhotoListUseCase.execute(startIndex: 0, limit: limitPage);
      photos.value = [];
      photos.addAll(result);
      isLoading(false);

      currentPage = 0;
      photos.refresh();
    } catch (e) {
      isLoading(false);
      photos.refresh();
    }
  }

  void _fetchMorePhotos() async {
    var loadingPage = currentPage + 1;

    isLoadingMore.value = true;
    final result = await getPhotoListUseCase.execute(
        startIndex: loadingPage, limit: limitPage);
    if (result.length < limitPage) {
      isCanLoadMore.value = false;
    }
    currentPage = loadingPage;
    photos.addAll(result);
    isLoadingMore.value = false;
    photos.refresh();
  }

  void onPhotoSelected(int index) {
    Get.toNamed(AppRoutes.photoView, arguments: photos[index]);
  }

  void onBookMarksPressed() {
    Get.toNamed(AppRoutes.bookmarks);
  }
}
