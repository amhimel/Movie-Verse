import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';
import 'package:movie_verse/repositories/movies_repo.dart';
import 'package:movie_verse/screens/movie_detail_screen.dart';
import 'package:movie_verse/services/api_service.dart';
import 'package:movie_verse/widgets/genres_widget.dart';
import 'package:provider/provider.dart';
import '../constants/my_app_constants.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';
import 'favorite_btn_widget.dart';
import 'gradient_button.dart';

class MoviePromoCard extends StatelessWidget {
  final VoidCallback? onWatchTrailer;

  const MoviePromoCard({
    super.key,
    this.onWatchTrailer,
  });

  @override
  Widget build(BuildContext context) {
    final moviesModelProvider = Provider.of<MovieModel>(context);
    return InkWell(
      onTap: () async {
        log("detail clicked");
        getIt<NavigationService>().navigate(
          MovieDetailScreen(movieModel: moviesModelProvider),
        );
      },
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //margin: const EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Poster
            Hero(
              tag: "movie_${moviesModelProvider.id}",
              child: CachedNetworkImage(
                imageUrl:
                    '${MyAppConstants.imagePath}${moviesModelProvider.backdropPath!}',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),

            // Watch Trailer button
            Positioned(
              right: 10,
              bottom: 150,
              child: ElevatedButton.icon(
                onPressed: onWatchTrailer,
                label: const Text(
                  "Watch Trailer",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.play_arrow,
                  size: 18,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyAppColors.darkSecondaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            // Bottom details card
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MyAppColors.darkSecondaryColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TRENDING",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            moviesModelProvider.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "A · ${moviesModelProvider.originalLanguage}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right book button + format
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FavoriteBtnWidget(movieModel: moviesModelProvider),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              MyAppIcons.iconWatchLaterOutlined,
                              size: 20,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              moviesModelProvider.releaseDate!,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
