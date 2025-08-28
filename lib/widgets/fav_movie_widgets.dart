import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_app_constants.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';
import '../screens/movie_detail_screen.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';
import 'cached_image_widget.dart';
import 'favorite_btn_widget.dart';
import 'genres_widget.dart';

class FavMovieWidgets extends StatelessWidget {
  const FavMovieWidgets({
    super.key,
    //required this.movieModel
  });

  //final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final moviesModelProvider = Provider.of<MovieModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            // TODO: Navigate To The Movie Details Screen
            getIt<NavigationService>().navigate(
              ChangeNotifierProvider.value(
                value: moviesModelProvider,
                child: MovieDetailScreen(
                  movieModel: moviesModelProvider
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //image border radius implementation
                  Hero(
                    tag: moviesModelProvider.id!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedImageWidget(
                        imageUrl: '${MyAppConstants.imagePath}${moviesModelProvider.backdropPath!}',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          MyAppIcons.iconError,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          moviesModelProvider.originalTitle!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 5),
                            Text("${moviesModelProvider.voteAverage?.toStringAsFixed(1)}/10"
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // TODO: Add the genres widget
                        GenresListWidget(
                          movieModel: moviesModelProvider,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MyAppIcons.iconWatchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              moviesModelProvider.releaseDate!,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteBtnWidget(
                              movieModel: moviesModelProvider,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}