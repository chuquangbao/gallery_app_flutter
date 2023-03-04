import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoZoomView extends StatelessWidget {
  final String imageUrl;

  const PhotoZoomView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.1,
          ),
        ),
      ),
    );
  }
}
