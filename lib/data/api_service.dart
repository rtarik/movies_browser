import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_browser/data/model/movie.dart';

import 'model/configuration.dart';

class ApiService {
  static const _base_url = 'https://api.themoviedb.org/3/';

  final String apiKey;
  static Configuration configuration;

  ApiService({this.apiKey});

  void getConfiguration() async {
    final url = _base_url + 'configuration?api_key=' + apiKey;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //print("configuration result: " + response.body);
      final imagesConfig = jsonDecode(response.body)['images'];
      configuration = Configuration.fromJson(imagesConfig);
    } else {
      throw Exception('<--- ' + url + " : " + response.statusCode.toString());
    }
  }

  Future<List<Movie>> fetchMovies() async {
    if (configuration == null) {
      getConfiguration();
    }
    final url = _base_url + 'discover/movie?api_key=' + apiKey;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final firstPage = jsonDecode(response.body)['results'];
      return firstPage.map<Movie>((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('<--- ' + url + " : " + response.statusCode.toString());
    }
  }
}
