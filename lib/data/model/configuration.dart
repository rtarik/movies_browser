class Configuration {
  final String baseUrl;
  final String posterSize;

  Configuration({this.baseUrl, this.posterSize});

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
      baseUrl: json['base_url'],
      posterSize: json['poster_sizes'][0],
    );
  }
}
