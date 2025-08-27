import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String apiKey = dotenv.get("MOVIE_API_KEY");
  static String bearerTokens = dotenv.get("MOVIE_BEARER_TOKEN");
  static String baseUrl = "https://api.themoviedb.org/3";

  static Map<String, String> get headers => {
    'Authorization': 'Bearer $bearerTokens',
    'accept': 'application/json',
  };
}