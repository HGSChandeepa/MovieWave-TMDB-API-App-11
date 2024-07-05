class TVShow {
  final String name;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final String firstAirDate;

  TVShow({
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.firstAirDate,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      name: json['name'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
      firstAirDate: json['first_air_date'],
    );
  }
}
