import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/photo_model.dart';
import '../models/photo_list_response.dart';

part 'photo_provider.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PhotoProvider {
  factory PhotoProvider(Dio dio, {String baseUrl}) = _PhotoProvider;

  @GET('/photos')
  Future<List<PhotoModel>> getPhotos();

  @GET('/photos/{id}')
  Future<PhotoModel> getPhoto(@Path('id') int id);

  @GET('/photos')
  Future<List<PhotoModel>> getAlbumPhotos(@Query('albumId') int albumId);

  @GET('/photos')
  Future<List<PhotoModel>> getUserPhotos(@Query('userId') int userId);

  @GET('/photos')
  Future<PhotoListResponse> getPhotosByPage(
    @Query('_page') int page,
    @Query('_limit') int limit,
  );
}
