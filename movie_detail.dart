import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie selectedMovie; //1
  const MovieDetail({Key? key, required this.selectedMovie}) : super(key: key); //2

  @override
  Widget build(BuildContext context) {
    String path; //3
    double screenHeight =
    MediaQuery.of(context).size.height; //ambil tinggi layar
    if (selectedMovie.posterPath !=null) {
      path = 'https://image.tmdb.org/t/p/w500/${selectedMovie.posterPath}'; //4
    }else {
      path = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMovie.title}'),
      ),
      body: SingleChildScrollView(
        //menambahkan fitur scroll
        child: Center(
          //menempatkan widget agar di tengah
          child: Column(
            children: <Widget>[
              Container(
                padding:  EdgeInsets.all(16), //menambahkan padding
                height: screenHeight / 1.5, //tinggi gambar
                child: Image.network(path),
              ),
                Text('${selectedMovie.overview}'),
            ],
          ),
        ),
    ));
  }
}
