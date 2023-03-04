import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';

abstract class GetPhotoListUseCase {
  Future<List<PhotoEntity>> execute(
      {required int startIndex, required int limit});
}
