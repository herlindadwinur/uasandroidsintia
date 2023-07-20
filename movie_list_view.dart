import 'package:flutter/material.dart';
import '../komponen/http_helper.dart';
import 'movie_detail.dart'; //1

class MovieListView extends StatefulWidget { //2
  const MovieListView({Key? key}) : super(key: key);

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
//3
  //tambahkan variabel
  Icon searcgIcon = Icon(Icons.search);
  Widget titleBar = Text('Daftar Film');

  late int moviesCount;
  late List movies;
  late HttpHelper helper;

  //tambahan iconBase
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.wikipedia.org%2Fwiki%2FDahlia&psig=AOvVaw1smRrmhPqamiqUkC83UwM0&ust=1689910831533000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJiC3ceunIADFQAAAAAdAAAAABAI';

  @override
  void initState() { //4
    defaultList();
    super.initState();
  }

  void toggleSearch() {
    setState(() {
      if (this.searcgIcon.icon == Icons.search) {
        this.searcgIcon = Icon(Icons.cancel);
        this.titleBar = TextField(
          autofocus: true,
          onSubmitted: (text) {
            searchMovies(text);
          },
          decoration : InputDecoration(hintText: 'Ketik kata pencarian'),
          textInputAction: TextInputAction.search,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        );
      }else {
        setState(() {
          this.searcgIcon = Icon(Icons.search);
          this.titleBar = Text('Daftar Film');
        });
        defaultList();
      }
    });
  }

  Future searchMovies(String text) async {
    List searchedMovies = await helper.findMovies(text);
    setState(() {
      movies = searchedMovies;
      moviesCount = movies.length;
    });
  }

  Future defaultList() async { //5
    moviesCount = 0;
    movies = [];
    helper = HttpHelper();
    List moviesFromAPI = [];
    moviesFromAPI = await helper.getUpComingAsList();
    setState(() {
      movies = moviesFromAPI;
      moviesCount = movies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image; //tambahkan image
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('UpComing'),
              onTap: () {
                Navigator.pop(context); //untuk menutup drawer
                setState(() {
                  this.searcgIcon =Icon(Icons.search);
                  this.titleBar = Text('Daftar Film');
                });
                defaultList(); //perintah getUpcoming()
              },
            ),
            ListTile(
              title: Text('Cari'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  this.searcgIcon = Icon(Icons.cancel);
                  this.titleBar = TextField(
                    autofocus: true,
                    onSubmitted: (text) {
                      searchMovies(text); //perintah cari Movie
                    },
                    decoration: InputDecoration(hintText: 'Ketik kata pencarian'),
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                });
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: titleBar,
        actions: [
          IconButton(
            icon: searcgIcon,
            onPressed: toggleSearch,
          ),
        ],
      ),
      body: ListView.builder( //6
        itemCount: moviesCount,
        itemBuilder: (context, position) {
          //tambahkan kode untuk akses image pada url
          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath);
          }else {
            image = NetworkImage(defaultImage);
          }
          //=====================================
          return Card( //7
            elevation: 2,
            child: ListTile( //8
              onTap: () { //1
                MaterialPageRoute route = MaterialPageRoute( //2
                  builder: (context) {
                    return MovieDetail(
                      selectedMovie: movies[position], //tambahan parameter
                    );
                  },
                );
                Navigator.push(context, route); //3
              },
              leading: CircleAvatar( // leading adalah kolom di depan title
              backgroundImage: image,
              ),
              title: Text(movies[position].title),
              subtitle: Text(
                'Released: ' +
                    movies[position].releaseDate +
                    ' - Vote: ' +
                    movies[position].voteAverage.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
