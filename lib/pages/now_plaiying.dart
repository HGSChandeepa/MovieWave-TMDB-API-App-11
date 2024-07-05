import 'package:flutter/material.dart';
import 'package:moviestmdb/models/movie_model.dart';
import 'package:moviestmdb/services/movie_service.dart';
import 'package:moviestmdb/widgets/movie_detail.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final MovieService _movieService = MovieService();
  List<Movie> _movies = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Movie> fetchedMovies =
          await _movieService.fetchNowPlayingMovies(page: _currentPage);
      setState(() {
        _movies = fetchedMovies;

        _totalPages = 10;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _fetchMovies();
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
      _fetchMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: _movies.length + 1,
                    itemBuilder: (context, index) {
                      if (index > _movies.length - 1) {
                        return _buildPaginationControls();
                      } else {
                        return MovieDetailsWidget(movie: _movies[index]);
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _currentPage > 1 ? _previousPage : null,
          child: const Text('Previous'),
        ),
        const SizedBox(width: 8),
        Text('Page $_currentPage of $_totalPages'),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _currentPage < _totalPages ? _nextPage : null,
          child: const Text('Next'),
        ),
      ],
    );
  }
}
