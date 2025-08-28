import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/my_app_constants.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';
import 'cached_image_widget.dart';

class PopularMovieCardWidget extends StatelessWidget {
  const PopularMovieCardWidget({super.key, /* required this.imageUrl, required this.title */});
  // final String imageUrl;
  // final String title;


  @override
  Widget build(BuildContext context) {
    final moviesModelProvider = Provider.of<MovieModel>(context);
    return Column(
      children: [
        Hero(
          tag: "movie_${moviesModelProvider.id}",
          child: CachedImageWidget(
            imageUrl: '${MyAppConstants.imagePath}${moviesModelProvider.backdropPath!}',
            width: 150,
            height: 180,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 60, color: Colors.white),
          ),
        ),
        Text(moviesModelProvider.title!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
      ],
    );
  }
}
