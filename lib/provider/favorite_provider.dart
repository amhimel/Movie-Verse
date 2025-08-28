import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

class FavoriteProvider with ChangeNotifier {
  final favKey = 'favoriteMovies';
  final List<MovieModel> _favoriteMoviesList = [];

  List<MovieModel> get favoriteMoviesList => _favoriteMoviesList;

  bool isFavorite(MovieModel movieModel) {
    return _favoriteMoviesList.any((movie) => movie.id == movieModel.id);
  }

  void addOrRemoveFromFavorites(MovieModel movieModel) {
    if (!isFavorite(movieModel)) {
      _favoriteMoviesList.add(movieModel);
    } else {
      _favoriteMoviesList.removeWhere((movie) => movie.id == movieModel.id);
    }
    //save the updated list to shared preferences or any other storage if needed
    saveFavorites();
    notifyListeners();
  }

  saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = _favoriteMoviesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    await prefs.setStringList(favKey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favKey);
    _favoriteMoviesList.clear();
    if (stringList != null) {
      for (String movieString in stringList) {
        final movieJson = json.decode(movieString);
        _favoriteMoviesList.add(MovieModel.fromJson(movieJson));
      }
    }
    // Notify listeners after loading favorites
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteMoviesList.clear();
    notifyListeners();
    saveFavorites();
  }
}