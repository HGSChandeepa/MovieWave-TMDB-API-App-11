import 'package:flutter/material.dart';
import 'package:moviestmdb/models/movie_model.dart';
import 'package:moviestmdb/services/movie_service.dart';
import 'package:moviestmdb/widgets/movie_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popular Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Movie> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  //This method fetches the popular movies from the API and this method is called in the initState method.

  // Here is the explanation of the code:
  // 1. The _fetchMovies method is an async method that fetches the popular movies from the API.
  // 2. The method checks if the _isLoading flag is true or if the _hasMore flag is false. If any of these conditions is true, the method returns.
  // 3. The _isLoading flag is set to true to indicate that the data is being fetched.
  // 4. The method waits for 1 second using the Future.delayed method to simulate a delay in fetching the data.
  // 5. The method fetches the popular movies using the MovieService class and the fetchPopularMovies method.
  // 6. The method updates the state with the new movies if the movies are not empty. If the movies are empty, the _hasMore flag is set to false to indicate that there are no more movies to fetch.
  // 7. If an error occurs during the fetching process, the error is caught and printed to the console.
  // 8. Finally, the _isLoading flag is set to false to indicate that the data fetching process is complete.

  Future<void> _fetchMovies() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    try {
      final newMovies =
          await MovieService().fetchPopularMovies(page: _currentPage);
      setState(() {
        if (newMovies.isEmpty) {
          _hasMore = false;
        } else {
          _movies.addAll(newMovies);
          _currentPage++;
        }
      });
    } catch (e) {
      print('Error: $e');
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
        title: const Text('Popular Movies'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchMovies();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: _movies.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _movies.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final movie = _movies[index];
            return MovieDetailsWidget(movie: movie);
          },
        ),
      ),
    );
  }
}
