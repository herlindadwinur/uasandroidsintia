class Movie {
  int? id; //untuk data "id" pada JSON
  String? title; //untuk data "title" pada JSON
  double? voteAverage; //untuk data "vote_average" pada JSON
  String? releaseDate; //untuk data "release_date" pada JSON
  String? overview; //untuk data "overview" pada JSON
  String? posterPath; //untuk data "poster_path" pada JSON

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview,
      this.posterPath);

  Movie.fromJson(Map<String, dynamic> json) { //1
    this.id = json['id'] as int;
    this.title = json['title'];
    this.voteAverage = json['vote_average'] * 1.0 as double;
    this.releaseDate = json["release_date"];
    this.overview = json["overview"];
    this.posterPath = json["poster_path"];
  }
}