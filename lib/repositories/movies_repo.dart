import '../models/movie_genres.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MoviesRepo {
  final ApiService _apiService;

  MoviesRepo(this._apiService);

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }

  Future<List<MovieModel>> fetchTrendingMovies() async {
    return await _apiService.fetchTrendingMovies();
  }

  Future<List<MovieGenres>> fetchGenres() async {
    return await _apiService.fetchGenres();
  }
}
