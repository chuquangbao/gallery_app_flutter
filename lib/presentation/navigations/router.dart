import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/presentation/pages/bookmark_page.dart';
import 'package:gallery_app_flutter/presentation/pages/gallery_page.dart';
import 'package:gallery_app_flutter/presentation/pages/photo_view_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.gallery:
        return GetPageRoute(
          page: () => GalleryPage(),
          settings: settings,
        );
      case AppRoutes.photoView:
        final args = settings.arguments as PhotoEntity;
        return GetPageRoute(
          page: () => PhotoViewPage(photo: args),
          settings: settings,
        );
      case AppRoutes.bookmarks:
        return GetPageRoute(
          page: () => BookmarkPage(),
          settings: settings,
        );
      default:
        return GetPageRoute(
          page: () => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
