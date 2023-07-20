//kode http_helper.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/movie.dart';
class HttpHelper {
/*
Kelas ini digunakan untuk mendapatkan data dari themoviedb
dengan metode Upcoming yang memberikan nilai return berupa teks
*/

  final String urlKey = 'api_key=2281f50b8f48cc2665b7f87f00123d26'; //1
  final String urlBase = 'https://api.themoviedb.org/3/movie'; //2
  final String urlUpcoming = '/upcoming?'; //3
  final String urlLanguage = '&language=en-US'; //4
  final String urlSearchBase = 'https://api.themoviedb.org/3/search/movie?''api_key=2281f50b8f48cc2665b7f87f00123d26&query=';

  Future<String> getUpcoming() async {
    //5
    final Uri upcoming = Uri.parse(
        urlBase + urlUpcoming + urlKey + urlLanguage);

//6
    http.Response result = await http.get(upcoming); //7
    if (result.statusCode == HttpStatus.ok) { //8
      String responseBody = result.body;
      return responseBody; //9
    }
    else {
      return '{}'; //10
    }
  }

  Future<List> getUpComingAsList() async {
    final Uri upcoming = Uri.parse(
        urlBase + urlUpcoming + urlKey + urlLanguage);
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(result.body); //1
      final movieObjects = jsonResponseBody['results']; //2
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();
//3
      return movies;
    } else {
      return [];
    }
  }

  findMovies(String text) {}
}

Future<List> getTopRatedAsList() async {
  String urlTopRated ='';
  final Uri topRated = Uri.parse(urlTopRated);
  http.Response result = await http.get(topRated);
  if (result.statusCode == HttpStatus.ok) {
    final jsonResponseBody = json.decode(result.body);
    final movieObjects = jsonResponseBody['results'];
    List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();
  return movies;
  }else {
  return [];
  }
}

  Future<List> findMovies(String title) async { //1
  var urlSearchBase;
  final Uri query = Uri.parse(urlSearchBase + title); //2
    http.Response hasilCari = await http.get(query); //3
    if (hasilCari.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(hasilCari.body); //4
      final movieObjects = jsonResponseBody['results']; //5
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList(); //6
      return movies; //7
    }else {
      return []; //8
    }
  }

