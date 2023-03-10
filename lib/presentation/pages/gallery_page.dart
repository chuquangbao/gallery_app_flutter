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
      var isLoading = mController.isLoading.value;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery Flutter'),
          actions: [
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    mController.onBookMarksPressed();
                  },
                  child: Text('Bookmarks'),
                ),
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            mController.loadPhotos();
          },
          child: isLoading
              ? _renderLoading()
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

  Widget _renderLoading() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Colors.red[400],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Loading',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
