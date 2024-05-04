class Movie {
  final int id; 
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String originalTitle;
  final String backdropPath;
  final String overview;
  final int voteCount;

  Movie({
    required this.id, 
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.originalTitle,
    required this.backdropPath,
    required this.overview,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'], 
      posterPath: json['poster_path'] ?? '',
      title: json['title'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble() ?? 0.0,
      originalTitle: json['original_title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
