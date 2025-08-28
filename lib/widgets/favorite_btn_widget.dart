import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';
import '../provider/favorite_provider.dart';
import '../services/navigation_service.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key,  required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, FavoriteProvider favoriteProvider, child) {
          return IconButton(
            icon: Icon(
              favoriteProvider.isFavorite(movieModel) ? MyAppIcons.favoriteRound : MyAppIcons.favoriteOutlineRound,
              size: 20,
              color: favoriteProvider.isFavorite(movieModel) ? Colors.red : null,
            ),
            onPressed: () {
              favoriteProvider.addOrRemoveFromFavorites(movieModel);
            },
          );
        }
    );
  }
}
