import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';

import 'gradient_button.dart';

class MoviePromoCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String language;
  final String genre;
  final String format;
  final VoidCallback? onWatchTrailer;
  final VoidCallback? onBook;

  const MoviePromoCard({
    super.key,
    required this.posterUrl,
    required this.title,
    required this.language,
    required this.genre,
    required this.format,
    this.onWatchTrailer,
    this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //margin: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Poster
          CachedNetworkImage(
            imageUrl: posterUrl,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 60, color: Colors.white),
          ),

          // Watch Trailer button
          Positioned(
            right: 10,
            bottom: 150,
            child: ElevatedButton.icon(
              onPressed: onWatchTrailer,
              label: const Text("Watch Trailer",
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.play_arrow, size: 18, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyAppColors.darkSecondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "A · $language",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          genre,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GradientButton(
                        text: "Book",
                        onPressed: onBook,
                        colors: [Color(0xFF323232), Color(0xFF767676)], // gradient
                        borderRadius: BorderRadius.circular(12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      // ElevatedButton(
                      //   onPressed: onBook,
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.grey[800],
                      //     foregroundColor: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 20,
                      //       vertical: 10,
                      //     ),
                      //   ),
                      //   child: const Text("Book"),
                      // ),
                      const SizedBox(height: 6),
                      Text(
                        format,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
