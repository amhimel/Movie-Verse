import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_genres.dart';
import '../provider/movie_provider.dart';
import '../repositories/movies_repo.dart';
import '../services/init_getIt.dart';


class GenreUtils {
  static List<MovieGenres> movieGenresNames(
      List<int> genreIds,
      BuildContext context,
      ) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    final moviesRepository = getIt<MoviesRepo>();
    final cachedGenres = moviesProvider
        .genresList; //TODO: We need to get the correct cachedGenres
    List<MovieGenres> genresNames = [];
    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
            (g) => g.id == genreId,
        orElse: () => MovieGenres(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}