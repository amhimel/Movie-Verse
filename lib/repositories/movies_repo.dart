import '../models/movie_genres.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

class MoviesRepo {
  final ApiService _apiService;

  MoviesRepo(this._apiService);

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    return await _apiService.fetchMovies(page: page);
  }
  Future<List<MovieModel>> searchMovies({String? query}) async {
    return await _apiService.searchMovies(query!);
  }
  Future<List<MovieModel>> fetchTvShows({int page = 1}) async {
    return await _apiService.fetchTvShows(page: page);
  }

  Future<List<MovieModel>> fetchTrendingMovies() async {
    return await _apiService.fetchTrendingMovies();
  }

  Future<List<MovieGenres>> fetchMoviesGenres() async {
    return await _apiService.fetchMoviesGenres();
  }
  Future<List<MovieGenres>> fetchTvGenres() async {
    return await _apiService.fetchTvGenres();
  }

  Future<String?> fetchMovieTrailer(int movieId) async {
    return await _apiService.fetchMovieTrailer(movieId);
  }



}
