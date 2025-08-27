import 'package:flutter/material.dart';
import '../constants/my_app_constants.dart';
import '../models/movie_model.dart';
import '../widgets/cached_image_widget.dart';
import '../widgets/favorite_btn_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: movieModel.id!,
              child: SizedBox(
                height: size.height * 0.45,
                width: double.infinity,
                child: CachedImageWidget(
                  imageUrl:  movieModel.posterPath!,//'${MyAppConstants.imagePath}${movieModel.backdropPath!}',
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 50, color: Colors.red),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.4,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 25),
                                  Text(
                                    movieModel.title!,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text("${movieModel.voteAverage?.toStringAsFixed(1)}/10"),
                                      Spacer(),
                                      Text(
                                        movieModel.releaseDate!,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  //GenresListWidget(movieModel: movieModel,),
                                  const SizedBox(height: 15),
                                  Text(
                                    movieModel.overview!,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: FavoriteBtnWidget(), //FavoriteBtnWidget(movieModel: movieModel,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )

            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const BackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}