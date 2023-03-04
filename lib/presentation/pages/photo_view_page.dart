import 'package:flutter/material.dart';

import 'package:gallery_app_flutter/domain/entities/photo_entity.dart';
import 'package:gallery_app_flutter/presentation/widgets/photo_zoom_view.dart';

class PhotoViewPage extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoViewPage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: SafeArea(
        child: Center(
          child: PhotoZoomView(
            imageUrl: photo.imageUrl,
          ),
        ),
      ),
    );
  }
}
