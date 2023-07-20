import 'package:flutter/material.dart';
import '../komponen/http_helper.dart'; //1


class MovieList extends StatefulWidget {  //2
  const MovieList ({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState(); //3
}

class _MovieListState extends State<MovieList> { //4
  String result = ''; //5
  HttpHelper helper = HttpHelper(); //6

  @override
  Widget build(BuildContext context) {
    helper.getUpcoming().then((value){ //7
      setState(() { //8
        result = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Film'),
      ),
      body: Text(result),
    );
  }
}
