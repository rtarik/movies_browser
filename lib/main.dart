import 'package:flutter/material.dart';

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(),
    );
  }
}
