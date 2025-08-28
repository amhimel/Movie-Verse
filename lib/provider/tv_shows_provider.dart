import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/movie_genres.dart';
import '../models/movie_model.dart';
import '../repositories/movies_repo.dart';
import '../services/init_getIt.dart';

class TvShowsProvider with ChangeNotifier {
  int _currentPage = 1;

  final List<MovieModel> _tvShowList = [];
  List<MovieModel> get tvShowList => _tvShowList;

  List<MovieGenres> _tvGenresList = [];
  List<MovieGenres> get tvGenresList => _tvGenresList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepo _moviesRepository = getIt<MoviesRepo>();

  Future<void> getTvShows() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_tvGenresList.isEmpty) {
        _tvGenresList = await _moviesRepository.fetchTvGenres();
      }
      List<MovieModel> movies = await _moviesRepository.fetchTvShows(
        page: _currentPage,
      );
      _tvShowList.addAll(movies);
      _currentPage++;
      _fetchMoviesError = "";
    } catch (error) {
      log("An error occurred in fetch movies $error");
      _fetchMoviesError = error.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
