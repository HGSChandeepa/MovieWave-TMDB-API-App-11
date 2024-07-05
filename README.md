# MovieWave 🎬

**MovieWave** is a Flutter application that fetches and displays movie details using The Movie Database (TMDb) API. The app supports features like pagination, infinite scrolling, animated page transitions, and movie detail views with similar and recommended movies.

---

![App](https://github.com/HGSChandeepa/MovieWave-TMDB-API-App-11/blob/main/1.png) 

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [API Integration](#api-integration)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

---

## Features

- **Popular Movies**: Fetch and display popular movies with infinite scrolling.
- **Movie Details**: Show detailed information about each movie.
- **Animated Transitions**: Smooth page transitions using various animations.
- **Similar & Recommended Movies**: Display similar and recommended movies for each selected movie.
- **Search**: Search for movies using keywords.
- **Pagination**: Manage and display paginated movie data.
- **TV Shows**: Show TV shows by categories like popular, airing today, and top-rated.

---

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/HGSChandeepa/MovieWave-TMDB-API-App-11
    cd MovieWave
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the app**:
    ```bash
    flutter run
    ```

---

## Usage

- **Home Page**: Displays a list of popular movies. Scroll down to load more movies.
- **Movie Details**: Tap on a movie to view its details, similar movies, and recommended movies.
- **Search**: Use the search bar to find movies by title.
- **TV Shows**: View TV shows by selecting the TV Shows tab and see them categorized by popular, airing today, and top-rated.

---

## API Integration

This app integrates with The Movie Database (TMDb) API to fetch movie and TV show data. 

### API Methods

- **Fetch Popular Movies**:
    ```dart
    Future<List<Movie>> fetchPopularMovies({int page = 1})
    ```

- **Fetch Now Playing Movies**:
    ```dart
    Future<List<Movie>> fetchNowPlayingMovies({int page = 1})
    ```

- **Fetch Similar Movies**:
    ```dart
    Future<List<Movie>> fetchSimilarMovies(int movieId)
    ```

- **Fetch Recommended Movies**:
    ```dart
    Future<List<Movie>> fetchRecommendedMovies(int movieId)
    ```

- **Fetch Movie Images**:
    ```dart
    Future<List<String>> fetchImagesFormMovieId(int movieId)
    ```

- **Search Movies**:
    ```dart
    Future<List<Movie>> searchMovies(String query)
    ```

- **Fetch TV Shows**:
    ```dart
    Future<List<TVShow>> fetchPopularTVShows({int page = 1})
    Future<List<TVShow>> fetchAiringTodayTVShows({int page = 1})
    Future<List<TVShow>> fetchTopRatedTVShows({int page = 1})
    ```

---

## Project Structure

```plaintext
lib/
│
├── models/
│   ├── movie_model.dart
│   ├── tvshow_model.dart
│
├── pages/
│   ├── main_page.dart
│   ├── single_movie.dart
│   ├── search_movie_page.dart
│   ├── tv_shows_page.dart
│
├── services/
│   ├── movie_service.dart
│   ├── tvshow_service.dart
│
└── widgets/
    ├── movie_detail.dart
    ├── movie_card.dart
    ├── tvshow_card.dart
```

---

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`.
3. Commit your changes: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature/my-feature`.
5. Create a pull request.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgements

- [The Movie Database (TMDb)](https://www.themoviedb.org/) for providing the API and movie data.
- [Flutter](https://flutter.dev/) for the awesome framework.
- Icons by [FontAwesome](https://fontawesome.com/).
