import 'package:gallery_app_flutter/domain/repositories/photo_repository.dart';
import 'package:get/get.dart';

class GalleryPageController extends GetxController {
  final PhotoRepository repository;
  GalleryPageController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
