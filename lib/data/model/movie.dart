class Movie {
  final String title;
  final String overview;
  final String posterPath;

  Movie({this.title, this.overview, this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path']);
  }
}
