import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/my_app_colors.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';

class CachedDetailImageWidget extends StatelessWidget {
  const CachedDetailImageWidget({
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
      ],
    );
  }
}
