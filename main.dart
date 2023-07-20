import 'package:flutter/material.dart';
import 'package:moviedb_sintia/screen/movie_list_view.dart';
import 'screen/movie_list.dart'; //1

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      home: MovieListView(),
    );
  }
}
