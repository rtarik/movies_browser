class Movie {
  final String title;

  Movie({this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(title: json['title']);
  }
}