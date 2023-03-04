import 'package:flutter/material.dart';
import 'package:gallery_app_flutter/presentation/controllers/gallery_controller.dart';
import 'package:get/get.dart';

class GalleryPage extends StatelessWidget {
  final mController = GalleryController();
  GalleryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var body = Obx(() {
      var photos = mController.photos.value;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery Flutter'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            mController.loadPhotos();
          },
          child: GridView.builder(
            controller: mController.scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              var imageUrl = photos[index].thumbnailUrl;
              return GestureDetector(
                onDoubleTap: () {
                  // Open the full-size photo
                  mController.onPhotoSelected(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });

    return GetBuilder(
      init: mController,
      builder: (controller) {
        return body;
      },
    );
  }
}
