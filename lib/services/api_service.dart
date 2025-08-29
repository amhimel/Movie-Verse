import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constant.dart';
import '../models/movie_genres.dart';
import '../models/movie_model.dart';

class ApiService {

  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/movie/popular?language=en-US&$page",
    );
    final response = await http.get(
      url,
      headers: ApiConstants.headers,
    );
    if (response.statusCode == 200) {
      // Handle successful response
      final data = jsonDecode(response.body);
      return List.from(data['results'])
          .map((elements) => MovieModel.fromJson(elements))
          .toList();
      // If you want to return a single MovieModel, you can modify this accordingly.
      debugPrint("Movies fetched successfully: $data");
    } else {
      // Handle error response
      debugPrint("Failed to fetch movies: ${response.statusCode}");
      throw Exception("Failed to load movies");
    }
  }
  Future<List<MovieModel>> fetchTvShows({int page = 1}) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/movie/popular?language=en-US&$page",
    );
    final response = await http.get(
      url,
      headers: ApiConstants.headers,
    );
    if (response.statusCode == 200) {
      // Handle successful response
      final data = jsonDecode(response.body);
      return List.from(data['results'])
          .map((elements) => MovieModel.fromJson(elements))
          .toList();
      // If you want to return a single MovieModel, you can modify this accordingly.
      debugPrint("Movies fetched successfully: $data");
    } else {
      // Handle error response
      debugPrint("Failed to fetch movies: ${response.statusCode}");
      throw Exception("Failed to load movies");
    }
  }

  Future<String?> fetchMovieTrailer(int movieId) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/movie/$movieId/videos?language=en-US",
    );
    final response = await http.get(
      url,
      headers: ApiConstants.headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // TMDb returns multiple videos, we filter for YouTube trailers
      final results = data['results'] as List<dynamic>;
      final trailer = results.firstWhere(
            (v) => v['site'] == 'YouTube' && v['type'] == 'Trailer',
        orElse: () => null,
      );

      if (trailer != null) {
        final key = trailer['key']; // YouTube video key
        return key; // return only videoId instead of full URL
      }
      return null;
    } else {
      throw Exception("Failed to load trailer");
    }
  }




  Future<List<MovieModel>> fetchTrendingMovies() async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/trending/movie/day?language=en-US",
    );
    final response = await http.get(
      url,
      headers: ApiConstants.headers,
    );
    if (response.statusCode == 200) {
      // Handle successful response
      final data = jsonDecode(response.body);
      return List.from(data['results'])
          .map((elements) => MovieModel.fromJson(elements))
          .toList();
      debugPrint("Movies fetched successfully: $data");
    } else {
      // Handle error response
      debugPrint("Failed to fetch trending movies: ${response.statusCode}");
      throw Exception("Failed to load movies");
    }
  }

  // for get genres
  Future<List<MovieGenres>> fetchMoviesGenres() async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/genre/movie/list?language=en",
    );
    final response = await http.get(
      url,
      headers: ApiConstants.headers,
    );
    if (response.statusCode == 200) {
      // Handle successful response
      final data = jsonDecode(response.body);
      return List.from(data['genres'])
          .map((elements) => MovieGenres.fromJson(elements))
          .toList();
      // If you want to return a single MovieModel, you can modify this accordingly.
      debugPrint("Movies fetched successfully: $data");
    } else {
      // Handle error response
      debugPrint("Failed to fetch movie genres: ${response.statusCode}");
      throw Exception("Failed to load movie genres");
    }
  }

  Future<List<MovieGenres>> fetchTvGenres() async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/genre/tv/list?language=en",
    );
    final response = await http.get(
      url,
      headers: ApiConstants.headers,
    );
    if (response.statusCode == 200) {
      // Handle successful response
      final data = jsonDecode(response.body);
      return List.from(data['genres'])
          .map((elements) => MovieGenres.fromJson(elements))
          .toList();
      // If you want to return a single MovieModel, you can modify this accordingly.
      debugPrint("Movies fetched successfully: $data");
    } else {
      // Handle error response
      debugPrint("Failed to fetch movie genres: ${response.statusCode}");
      throw Exception("Failed to load movie genres");
    }
  }
}
