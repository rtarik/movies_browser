import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_browser/data/model/movie.dart';

class ApiService {

  static const _base_url = 'https://api.themoviedb.org/3/';

  final String apiKey;

  ApiService({this.apiKey});

  Future<List<Movie>> fetchMovies() async {
    final url = _base_url + 'discover/movie?api_key=' + apiKey;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final firstPage = jsonDecode(response.body)['results'];
      return firstPage.map<Movie>((json) => Movie.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Service returned: ' + response.statusCode.toString());
    }
  }
}
