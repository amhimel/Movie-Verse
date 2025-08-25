import 'package:flutter/material.dart';

import '../constants/my_app_icons.dart';
import 'cached_image_widget.dart';

class PopularMovieCardWidget extends StatelessWidget {
  const PopularMovieCardWidget({super.key, required this.imageUrl, required this.title});
  final String imageUrl;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedImageWidget(
          imageUrl: imageUrl,
          width: 150,
          height: 180,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) =>
          const Icon(Icons.broken_image, size: 60, color: Colors.white),
        ),
        Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
      ],
    );
  }
}
