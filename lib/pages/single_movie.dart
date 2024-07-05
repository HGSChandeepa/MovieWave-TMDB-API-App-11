import 'package:flutter/material.dart';
import 'package:moviestmdb/models/movie_model.dart';
import 'package:moviestmdb/services/movie_service.dart';
import 'package:moviestmdb/widgets/movie_details_single_page.dart';

class SingleMoviePage extends StatefulWidget {
  Movie movie;

  SingleMoviePage({super.key, required this.movie});

  @override
  State<SingleMoviePage> createState() => _SingleMoviePageState();
}

class _SingleMoviePageState extends State<SingleMoviePage> {
  final MovieService _movieService = MovieService();
  List<Movie> _similarMovies = [];
  List<Movie> _recommendedMovies = [];
  List<String> _movieImages = [];
  bool _isLoadingSimilar = true;
  bool _isLoadingRecommended = true;
  bool _isLoadingImages = true;

  @override
  void initState() {
    super.initState();
    _fetchSimilarMovies();
    _fetchRecommendedMovies();
    _fetchMovieImages();
  }

  Future<void> _fetchSimilarMovies() async {
    try {
      List<Movie> fetchedMovies =
          await _movieService.fetchSimilarMovies(widget.movie.id);
      setState(() {
        _similarMovies = fetchedMovies;
        _isLoadingSimilar = false;
      });
    } catch (e) {
      print('Error fetching similar movies: $e');
      setState(() {
        _isLoadingSimilar = false;
      });
    }
  }

  Future<void> _fetchRecommendedMovies() async {
    try {
      List<Movie> fetchedMovies =
          await _movieService.fetchRecommendedMovies(widget.movie.id);
      setState(() {
        _recommendedMovies = fetchedMovies;
        _isLoadingRecommended = false;
      });
    } catch (e) {
      print('Error fetching recommended movies: $e');
      setState(() {
        _isLoadingRecommended = false;
      });
    }
  }

  Future<void> _fetchMovieImages() async {
    try {
      List<String> fetchedImages =
          await _movieService.fetchImagesFromMovieId(widget.movie.id);
      setState(() {
        _movieImages = fetchedImages;
        _isLoadingImages = false;
      });
    } catch (e) {
      print('Error fetching movie images: $e');
      setState(() {
        _isLoadingImages = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieDetailsSinglepage(movie: widget.movie),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Movie Images',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildImageSection(),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Similar Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildMovieSection(_similarMovies, _isLoadingSimilar),
              _recommendedMovies.isNotEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Recommended Movies',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : const SizedBox(),
              _recommendedMovies.isNotEmpty
                  ? _buildMovieSection(
                      _recommendedMovies, _isLoadingRecommended)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    if (_isLoadingImages) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_movieImages.isEmpty) {
      return const Center(child: Text('No images found.'));
    }
    return SizedBox(
      height: 200, // Height for horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movieImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            margin: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                _movieImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieSection(List<Movie> movies, bool isLoading) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (movies.isEmpty) {
      return const Center(child: Text('No movies found.'));
    }
    return SizedBox(
      height: 200, // Height for horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.movie = movies[index];
                //fetch the images and the similar movies for the selected movie
                _fetchMovieImages();
                _fetchSimilarMovies();
                _fetchRecommendedMovies();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.all(4.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (movies[index].posterPath != null)
                      Expanded(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 100,
                      child: Text(
                        movies[index].title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Average Vote: ${movies[index].voteAverage}',
                      style: TextStyle(
                        fontSize: 7,
                        color: Colors.red[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
