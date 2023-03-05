import 'package:flutter/material.dart';
import 'package:gallery_app_flutter/data/providers/local_storage_provider.dart';
import 'package:gallery_app_flutter/data/providers/network_module.dart';
import 'package:gallery_app_flutter/data/providers/photo_provider.dart';
import 'package:gallery_app_flutter/data/repositories/bookmark_repository_impl.dart';
import 'package:gallery_app_flutter/data/repositories/photo_local_datasource.dart';
import 'package:gallery_app_flutter/data/repositories/photo_repository_impl.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase.dart';
import 'package:gallery_app_flutter/domain/usecases/bookmark_usecase_impl.dart';
import 'package:gallery_app_flutter/domain/usecases/get_photo_list_usecase_impl.dart';
import 'package:get/get.dart';

import 'presentation/navigations/app_routes.dart';
import 'presentation/navigations/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDIApplication();
  runApp(const MyApp());
}

void initDIApplication() {
  // Network API Services
  final networkModule = NetworkModule().dio;
  final localPhotoDataSource = PhotoLocalDataSource();
  final photoProvider = PhotoProvider(networkModule);
  final photoRepository = PhotoRepositoryImpl(
    photoProvider: photoProvider,
    localDataSource: localPhotoDataSource,
  );
  final getPhotoListUseCase = GetPhotoListUseCaseImpl(photoRepository);
  // Bookmark Data Source
  final bookMarkUseCase = BookmarkUseCaseImpl(
      BookmarkRepositoryImpl(lsProvider: LocalStorageProvider()));
  Get.put(getPhotoListUseCase, permanent: true); // Global Singleton Instance
  Get.put(bookMarkUseCase, permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gallery Fluter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.gallery,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
