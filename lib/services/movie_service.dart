import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:moviestmdb/models/movie_model.dart';

class MovieService {
  final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  //fetching popular movies
  final String _baseUrl = 'https://api.themoviedb.org/3/movie/popular';

  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey&page=$page'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      print('Error fetching movies: $error');
      return [];
    }
  }

  //fetch now playing movies
  final String _nowPlayingUrl =
      'https://api.themoviedb.org/3/movie/now_playing';

  Future<List<Movie>> fetchNowPlayingMovies({int page = 1}) async {
    try {
      final response = await http
          .get(Uri.parse('$_nowPlayingUrl?api_key=$_apiKey&page=$page'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      print('Error fetching movies: $error');
      return [];
    }
  }
}
