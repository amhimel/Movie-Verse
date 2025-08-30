import 'package:flutter/material.dart';
import 'package:movie_verse/screens/movie_detail_screen.dart';
import 'package:movie_verse/widgets/video_play_dialog.dart';
import 'package:provider/provider.dart';

import '../constants/my_app_constants.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';
import 'cached_image_widget.dart';

class PopularMovieCardWidget extends StatelessWidget {
  const PopularMovieCardWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final moviesModelProvider = Provider.of<MovieModel>(context);
    final movieProvider = Provider.of<MovieProvider>(context);
    return InkWell(
      onTap: (){
        getIt<NavigationService>().navigate(MovieDetailScreen(movieModel: moviesModelProvider));
      },
      child: Column(
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
              onWatchTrailer: () async {
                final videoId = await movieProvider.getMovieTrailer(moviesModelProvider.id!);
                if (videoId != null && context.mounted) {
                  getIt<NavigationService>().showMyDialog(VideoPlayDialog(videoId: videoId));

                } else {
                  getIt<NavigationService>().showSnackBar(Text("No trailer available"));

                }

              },
            ),
          ),

          Text(moviesModelProvider.title!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
}
