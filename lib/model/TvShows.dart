// To parse this JSON data, do
//
//     final tvShows = tvShowsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;


Future<TvShows> fetchShows() async{
  final url = "https://api.themoviedb.org/3/tv/popular?api_key=62feaff3d2cf094a340f530fbf25bde9&language=en-US&page=1";
  final response = await http.get(url);
  print(url);
  if (response.statusCode == 200) {
    print(response.body);
    return TvShows.fromJson(jsonDecode(response.body));
  }
  else
  {
    throw Exception(response.reasonPhrase);
  }
}

TvShows tvShowsFromJson(String str) => TvShows.fromJson(json.decode(str));

String tvShowsToJson(TvShows data) => json.encode(data.toJson());

class TvShows {
  TvShows({
    this.page,
    this.totalResults,
    this.totalPages,
    this.resultsShow,
  });

  int page;
  int totalResults;
  int totalPages;
  List<ResultShow> resultsShow;

  factory TvShows.fromJson(Map<String, dynamic> json) => TvShows(
    page: json["page"],
    totalResults: json["total_results"],
    totalPages: json["total_pages"],
    resultsShow: List<ResultShow>.from(json["results"].map((x) => ResultShow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "total_results": totalResults,
    "total_pages": totalPages,
    "results": List<dynamic>.from(resultsShow.map((x) => x.toJson())),
  };
}

class ResultShow {
  ResultShow({
    this.originalName,
    this.genreIds,
    this.name,
    this.popularity,
    this.originCountry,
    this.voteCount,
    this.firstAirDate,
    this.backdropPath,
    this.originalLanguage,
    this.id,
    this.voteAverage,
    this.overview,
    this.posterPath,
  });

  String originalName;
  List<int> genreIds;
  String name;
  double popularity;
  List<OriginCountry> originCountry;
  int voteCount;
  DateTime firstAirDate;
  String backdropPath;
  OriginalLanguage originalLanguage;
  int id;
  double voteAverage;
  String overview;
  String posterPath;

  factory ResultShow.fromJson(Map<String, dynamic> json) => ResultShow(
    originalName: json["original_name"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    name: json["name"],
    popularity: json["popularity"].toDouble(),
    originCountry: List<OriginCountry>.from(json["origin_country"].map((x) => originCountryValues.map[x])),
    voteCount: json["vote_count"],
    firstAirDate: DateTime.parse(json["first_air_date"]),
    backdropPath: json["backdrop_path"],
    originalLanguage: originalLanguageValues.map[json["original_language"]],
    id: json["id"],
    voteAverage: json["vote_average"].toDouble(),
    overview: json["overview"],
    posterPath: json["poster_path"],
  );

  Map<String, dynamic> toJson() => {
    "original_name": originalName,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "name": name,
    "popularity": popularity,
    "origin_country": List<dynamic>.from(originCountry.map((x) => originCountryValues.reverse[x])),
    "vote_count": voteCount,
    "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "backdrop_path": backdropPath,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "id": id,
    "vote_average": voteAverage,
    "overview": overview,
    "poster_path": posterPath,
  };
}

enum OriginCountry { US, ES }

final originCountryValues = EnumValues({
  "ES": OriginCountry.ES,
  "US": OriginCountry.US
});

enum OriginalLanguage { EN, ES }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}