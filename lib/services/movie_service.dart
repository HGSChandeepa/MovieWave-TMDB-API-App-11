import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:moviestmdb/models/movie_model.dart';

class MovieService {
  final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  //fetching popular movies
  final String _baseUrl = 'https://api.themoviedb.org/3/movie/upcoming';

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

  //fethcing similar movies
  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$_apiKey'));

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

  //fetching recommended movies
  Future<List<Movie>> fetchRecommendedMovies(int movieId) async {
    try {
      print(movieId);
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$_apiKey&page=1'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
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

  // Fetch images by movie ID
  Future<List<String>> fetchImagesFromMovieId(int movieId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> backdrops = data['backdrops'];

        // Extract file paths and return the first 10 images
        return backdrops
            .take(10)
            .map((imageData) =>
                'https://image.tmdb.org/t/p/w500${imageData['file_path']}')
            .toList();
      } else {
        throw Exception('Failed to load images');
      }
    } catch (error) {
      print('Error fetching images: $error');
      return [];
    }
  }

  //search movies by query
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?query=$query&api_key=$_apiKey'));

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
