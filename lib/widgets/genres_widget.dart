import 'package:flutter/material.dart';
import '../models/movie_genres.dart';
import '../models/movie_model.dart';
import '../utill/genres_util.dart';

class GenresListWidget extends StatelessWidget {
  const GenresListWidget({
    super.key,
    required this.movieModel
  });

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    List<MovieGenres> movieGenres = GenreUtils.movieGenresNames(
      movieModel.genreIds!,
      context,
    );
    return Wrap(
      children: List.generate(
        movieGenres.length,
            (index) =>
            chipWidget(genresName: movieGenres[index].name, context: context),
      ),
    );
  }

  Widget chipWidget({
    required String genresName,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
          border: BoxBorder.all(color: Theme.of(context).colorScheme.surface),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Text(
            genresName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}