import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/domain/repositories/photo_repository.dart';

import 'get_photo_list_usecase.dart';

class GetPhotoListUseCaseImpl implements GetPhotoListUseCase {
  final PhotoRepository photoRepository;

  GetPhotoListUseCaseImpl(this.photoRepository);

  @override
  Future<List<PhotoEntity>> execute(
      {required int startIndex, required int limit}) {
    return photoRepository.getPhotosByPage(page: startIndex, limit: 30);
  }
}
