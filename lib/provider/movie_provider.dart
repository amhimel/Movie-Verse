import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/movie_genres.dart';
import '../models/movie_model.dart';
import '../repositories/movies_repo.dart';
import '../services/init_getIt.dart';

class MovieProvider with ChangeNotifier {
  int _currentPage = 1;

  final List<MovieModel> _moviesList = [];
  List<MovieModel> get moviesList => _moviesList;

  List<MovieGenres> _genresList = [];
  List<MovieGenres> get genresList => _genresList;

  final List<MovieModel> _moviesTrendList = [];
  List<MovieModel> get moviesTrendList => _moviesTrendList;

  List<MovieGenres> _genresTrendList = [];
  List<MovieGenres> get genresTrendList => _genresTrendList;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  // ✅ For search
  List<MovieModel> _searchResults = [];
  List<MovieModel> get searchResults => _searchResults;

  final MoviesRepo _moviesRepository = getIt<MoviesRepo>();

  Future<void> getMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_genresList.isEmpty) {
        _genresList = await _moviesRepository.fetchMoviesGenres();
      }
      List<MovieModel> movies =
      await _moviesRepository.fetchMovies(page: _currentPage);
      _moviesList.addAll(movies);
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
  Future<void> getTrendingMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_genresTrendList.isEmpty) {
        _genresTrendList = await _moviesRepository.fetchMoviesGenres();
      }
      List<MovieModel> movies =
      await _moviesRepository.fetchTrendingMovies();
      _moviesTrendList.addAll(movies);
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

  Future<String?> getMovieTrailer(int movieId) async {
    return await _moviesRepository.fetchMovieTrailer(movieId);
  }

  // ✅ New: Search movies
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _moviesRepository.searchMovies(query: query);
      _fetchMoviesError = "";
    } catch (error) {
      log("An error occurred in searchMovies $error");
      _fetchMoviesError = error.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Optional: clear results (for search bar clear button)
  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }


}
