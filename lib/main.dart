import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/navigations/app_routes.dart';
import 'presentation/navigations/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final photoRepository = PhotoRepositoryImpl(PhotoProvider());
  // final getPhotoListUsecase = GetPhotoListUsecaseImpl(photoRepository);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.gallery,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
