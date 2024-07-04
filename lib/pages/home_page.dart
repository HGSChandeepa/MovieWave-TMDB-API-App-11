import 'package:flutter/material.dart';
import 'package:moviestmdb/pages/main_page.dart';
import 'package:moviestmdb/pages/now_plaiying.dart';
import 'package:moviestmdb/pages/popular_movies.dart';
import 'package:moviestmdb/pages/upcoming_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pages = [
    const MainPage(),
    const NowPlayingPage(),
    const PopularMoviesPage(),
    const UpcomingMoviesPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill),
            label: "Now Playing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Popular",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Upcoming",
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.blue,
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
