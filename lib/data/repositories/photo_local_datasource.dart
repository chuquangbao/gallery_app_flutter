import 'dart:convert';
import 'package:gallery_app_flutter/data/models/photo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoLocalDataSource {
  static const _kPhotosKey = 'photos';
  PhotoLocalDataSource();
  Future<List<PhotoModel>> getCachedPhotos() async {
    var preferences = await SharedPreferences.getInstance();
    final jsonPhotos = preferences.getStringList(_kPhotosKey);
    if (jsonPhotos != null) {
      return jsonPhotos
          .map((json) => PhotoModel.fromJson(jsonDecode(json)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> cachePhotos(List<PhotoModel> photos) async {
    var preferences = await SharedPreferences.getInstance();
    final jsonPhotos =
        photos.map((photo) => jsonEncode(photo.toJson())).toList();
    await preferences.setStringList(_kPhotosKey, jsonPhotos);
  }
}
