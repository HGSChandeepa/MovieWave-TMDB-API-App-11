import 'package:flutter/material.dart';
import 'package:moviestmdb/models/movie_model.dart';
import 'package:moviestmdb/services/movie_service.dart';
import 'package:moviestmdb/widgets/movie_details_single_page.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  _SearchMoviePageState createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  final TextEditingController _searchController = TextEditingController();
  final MovieService _movieService = MovieService();
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  // Method to search for movies
  Future<void> _searchMovies() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      List<Movie> movies =
          await _movieService.searchMovies(_searchController.text);
      setState(() {
        _searchResults = movies;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load movies: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search for a movie',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                      onSubmitted: (_) => _searchMovies(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red[600],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                        weight: 10,
                      ),
                      onPressed: _searchMovies,
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_error, style: const TextStyle(color: Colors.red)),
              )
            else if (_searchResults.isEmpty)
              const Expanded(
                child: Center(child: Text('No movies found.Please search...')),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MovieDetailsSinglepage(movie: _searchResults[index]),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
