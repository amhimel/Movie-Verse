import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/my_app_colors.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    required this.errorWidget,
    //required this.videoId,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget Function(BuildContext context, String url, dynamic error) errorWidget;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double defaultWidth = size.width * 0.3;
    final double defaultHeight = size.height * 0.2;
    return Stack(
      children: [
        CachedNetworkImage(
          height: height ?? defaultHeight,
          width: width ?? defaultWidth,
          fit: fit ?? BoxFit.cover,
          imageUrl: imageUrl,
          errorWidget: errorWidget,
        ),

        // Watch Trailer button
        Positioned(
          right: 10,
          bottom: 60,
          child: ElevatedButton.icon(
            onPressed: (){},
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
      ],
    );
  }
}
