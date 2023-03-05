import 'package:flutter/material.dart';
import 'package:gallery_app_flutter/presentation/controllers/bookmarks_controller.dart';
import 'package:get/get.dart';

class BookmarkPage extends StatelessWidget {
  final mController = BookmarkController();
  BookmarkPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var body = Obx(() {
      var photos = mController.bookmarks.value;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            mController.loadPhotos();
          },
          child: mController.isNoData
              ? _renderNoDataPage()
              : GridView.builder(
                  controller: mController.scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    var imageUrl = photos[index].thumbnailUrl;
                    return GestureDetector(
                      onTap: () {
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

  Widget _renderNoDataPage() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/images/empty.png',
            )),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Touch icon ♡ when view photo',
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
