import 'dart:convert';

import 'package:flutter/material.dart';

import 'data/api_service.dart';
import 'data/model/movie.dart';

void main() {
  runApp(MoviesBrowserApp());
}

Map<int, Color> primaryColorMap = {
  50: Color.fromRGBO(13, 37, 63, .1),
  100: Color.fromRGBO(13, 37, 63, .2),
  200: Color.fromRGBO(13, 37, 63, .3),
  300: Color.fromRGBO(13, 37, 63, .4),
  400: Color.fromRGBO(13, 37, 63, .5),
  500: Color.fromRGBO(13, 37, 63, .6),
  600: Color.fromRGBO(13, 37, 63, .7),
  700: Color.fromRGBO(13, 37, 63, .8),
  800: Color.fromRGBO(13, 37, 63, .9),
  900: Color.fromRGBO(13, 37, 63, 1),
};

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: MaterialColor(0xFF0d253f, primaryColorMap),
  accentColor: Colors.green[400],
);

class MoviesBrowserApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Browser',
      theme: kDefaultTheme,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService;
  Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    _getApiKey().then((apiKey) {
      setState(() {
        apiService = ApiService(apiKey: apiKey);
        apiService.getConfiguration();
        futureMovies = apiService.fetchMovies();
      });
    });
  }

  Future<String> _getApiKey() async {
    final json =
        await DefaultAssetBundle.of(context).loadString('assets/secrets.json');
    return jsonDecode(json)['api_key'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MoviesList(
              movies: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MoviesList extends StatelessWidget {
  final List<Movie> movies;

  const MoviesList({
    Key key,
    @required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (_, int index) => MovieItem(movie: movies[index]),
      itemCount: movies.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 2.0,
        );
      },
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(right: 16.0),
          child: Image.network(_getPosterUrl(movie)),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: Text(movie.title,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Text(
                movie.overview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ]),
    );
  }

  String _getPosterUrl(Movie movie) {
    final config = ApiService.configuration;
    if (config != null) {
      return config.baseUrl + config.posterSize + movie.posterPath;
    } else {
      return "";
    }
  }
}
