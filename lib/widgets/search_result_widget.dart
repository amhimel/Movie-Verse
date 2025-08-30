import 'package:flutter/material.dart';
import 'package:movie_verse/widgets/video_play_dialog.dart';
import 'package:provider/provider.dart';
import '../constants/my_app_constants.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';
import '../screens/movie_detail_screen.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';
import 'cached_image_widget.dart';
import 'favorite_btn_widget.dart';
import 'genres_widget.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.movieModel,
  });

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>().navigate(
              MovieDetailScreen(movieModel: movieModel),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with Hero
                  Hero(
                    tag: movieModel.id!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedImageWidget(
                        imageUrl: '${MyAppConstants.imagePath}${movieModel.backdropPath ?? movieModel.posterPath}',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          MyAppIcons.iconError,
                          size: 50,
                          color: Colors.red,
                        ),
                        onWatchTrailer: () async {
                          final videoId = await movieProvider.getMovieTrailer(movieModel.id!);
                          if (videoId != null && context.mounted) {
                            getIt<NavigationService>().showMyDialog(
                              VideoPlayDialog(videoId: videoId),
                            );
                          } else {
                            getIt<NavigationService>().showSnackBar(
                              const Text("No trailer available"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Info Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieModel.originalTitle ?? movieModel.title ?? "Unknown",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              "${movieModel.voteAverage?.toStringAsFixed(1) ?? '0.0'}/10",
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GenresListWidget(movieModel: movieModel),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              MyAppIcons.iconWatchLaterOutlined,
                              size: 18,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              movieModel.releaseDate ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteBtnWidget(movieModel: movieModel),
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
