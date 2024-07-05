import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviestmdb/models/tv_show_model.dart';

class TvShowService {
  final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  Future<List<TVShow>> fetchTVShows() async {
    try {
      final popularResponse = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey'));
      final airingTodayResponse = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/airing_today?api_key=$_apiKey'));
      final topRatedResponse = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/top_rated?api_key=$_apiKey'));

      if (popularResponse.statusCode == 200 &&
          airingTodayResponse.statusCode == 200 &&
          topRatedResponse.statusCode == 200) {
        final popularData = json.decode(popularResponse.body);
        final airingTodayData = json.decode(airingTodayResponse.body);
        final topRatedData = json.decode(topRatedResponse.body);

        final List<dynamic> popularResults = popularData['results'];
        final List<dynamic> airingTodayResults = airingTodayData['results'];
        final List<dynamic> topRatedResults = topRatedData['results'];

        List<TVShow> tvShows = [];
        tvShows.addAll(
            popularResults.map((tvData) => TVShow.fromJson(tvData)).take(10));
        tvShows.addAll(airingTodayResults
            .map((tvData) => TVShow.fromJson(tvData))
            .take(10));
        tvShows.addAll(
            topRatedResults.map((tvData) => TVShow.fromJson(tvData)).take(10));

        return tvShows;
      } else {
        throw Exception('Failed to load TV shows');
      }
    } catch (error) {
      print('Error fetching TV shows: $error');
      return [];
    }
  }
}
