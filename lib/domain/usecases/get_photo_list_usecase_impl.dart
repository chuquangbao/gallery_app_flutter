import 'package:gallery_app_flutter/data/models/photo_model.dart';
import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/repositories/photo_repository.dart';

import 'get_photo_list_usecase.dart';

class GetPhotoListUseCaseImpl implements GetPhotoListUseCase {
  final PhotoRepository _photoRepository;

  GetPhotoListUseCaseImpl(this._photoRepository);

  @override
  Future<List<PhotoEntity>> execute(
      {required int startIndex, required int limit}) {
    return _photoRepository.getPhotoList(startIndex, limit);
  }
}
