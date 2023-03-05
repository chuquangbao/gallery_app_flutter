import 'package:flutter/material.dart';

import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/presentation/controllers/photo_view_controller.dart';
import 'package:gallery_app_flutter/presentation/widgets/photo_zoom_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PhotoViewPage extends StatelessWidget {
  final PhotoEntity photo;
  final mController = PhotoController();

  PhotoViewPage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainView = Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Obx(() {
        var isBookMark = mController.isBookMark.value;
        return SafeArea(
          child: Stack(
            children: [
              Center(
                child: PhotoZoomView(
                  imageUrl: photo.imageUrl,
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 30,
                  child: IconButton(
                      onPressed: () {
                        mController.onBookMarkPressed(photo);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isBookMark ? Colors.red : Colors.grey,
                        size: 50,
                      ))),
            ],
          ),
        );
      }),
    );

    return GetBuilder(
      init: mController,
      initState: (state) {
        // Update status bookmark
        mController.updateBookmark(photo.id);
      },
      builder: (controller) {
        return mainView;
      },
    );
  }
}
