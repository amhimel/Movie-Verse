import 'package:flutter/material.dart';
import '../constants/my_app_icons.dart';
import '../models/movie_model.dart';

class FavoriteBtnWidget extends StatefulWidget {
  const FavoriteBtnWidget({super.key, }); //required this.movieModel

  //final MovieModel movieModel;

  @override
  State<FavoriteBtnWidget> createState() => _FavoriteBtnWidgetState();
}

class _FavoriteBtnWidgetState extends State<FavoriteBtnWidget> {
  final favoriteMoviesIds = [];

  @override
  Widget build(BuildContext context) {
    //final isFavorite = favoriteMoviesIds.contains(widget.movieModel.id);
    return IconButton(
      icon: Icon(
        MyAppIcons.favoriteRound,  //isFavorite ? MyAppIcons.favoriteRound : MyAppIcons.favoriteOutlineRound,
        size: 30,
        color: Colors.red ,//isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        // Implement search functionality here
        // if (isFavorite) {
        //   favoriteMoviesIds.remove(widget.movieModel.id);
        // } else {
        //   favoriteMoviesIds.add(widget.movieModel.id);
        // }
        // setState(() {
        //
        // });
      },
    );
  }
}