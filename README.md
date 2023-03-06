# Gallery Flutter App - Clean Architect Template

## Project Description

This project follows the Clean Architecture pattern, with each layer being responsible for its own concerns. The data layer handles the retrieval and storage of data, the domain layer contains the business logic of the app, and the presentation layer handles the display of data and user interaction. The utils directory contains utility classes and constants used throughout the app.


<p align="center">
  <img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1" height="500">
</p>


## Directory Structure

* lib/data: contains the data layer of the app, including models, providers, and repositories.
* lib/domain: contains the domain layer of the app, including entities, repositories, and use cases.
* lib/presentation: contains the presentation layer of the app, including pages, widgets, blocs, and navigation.
* lib/utils: contains utility classes and constants used throughout the app.
* test: contains unit and integration tests for the app.
* pubspec.yaml: the project's dependencies and metadata.
* README.md: documentation for the project.

## Main Files

* main.dart: the entry point for the app.
* pubspec.yaml: the project's dependencies and metadata.
* README.md: documentation for the project.
* Testing

The test directory contains unit and integration tests for the app, following the same directory structure as the lib directory. Overall, this project follows Clean Code practices.

## Source Code

* Configure Dependency Injections

```
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
```

* Using GetX Package to manage state, route navigation.

[GetX Flutter Package.](https://pub.dev/packages/get) GetX Flutter Package.

```
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
```
Developer by chuquangbao@gmail.com



