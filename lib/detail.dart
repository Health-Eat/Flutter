import 'package:flutter/material.dart';
import 'package:flutter_app/model/Film.dart';
import 'package:flutter_app/model/TvShows.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class StarDisplay extends StatelessWidget {
  final int value;

  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(1, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'] as int, name: json['name']);
  }
}

class Detail extends StatelessWidget {
  final Result film;
  final ResultShow show;

  Future<List<Genre>> fetchGenres(String url) async {
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);

    return (jsonResponse['genres'] as List)
        .map((p) => Genre.fromJson(p))
        .toList();
  }

  Detail({Key key, this.film, this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 55, 63, 0.4),
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0.0,
      ),
      body: Stack(children: <Widget>[
        Column(children: [
          SizedBox(
              height: 350,
              child: Stack(children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          "http://image.tmdb.org/t/p/w1280/${film == null ? show.posterPath : film.posterPath}"),
                      fit: BoxFit.cover,
                    ))),
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: <Color>[
                        Colors.black.withAlpha(0),
                        Colors.black12,
                        Colors.black45
                      ],
                    ),
                  ),
                  child: Text(
                    film == null ? show.originalName : film.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ])),
          Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10.0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "+12 - ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    " ${film == null ? show.name : film.releaseDate.year.toString()} - ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  IconTheme(
                    data: IconThemeData(
                      color: Colors.amber,
                      size: 15,
                    ),
                    child: StarDisplay(value: 3),
                  ),
                  Text(
                    " ${film == null ? show.voteAverage.toString() : film.voteAverage.toString()}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder<List<Genre>>(
                      future: fetchGenres(
                          'https://api.themoviedb.org/3/genre/movie/list?api_key=62feaff3d2cf094a340f530fbf25bde9&language=en-US'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var names = [];

                          for (Genre genre in snapshot.data) {
                            /*print("${film.genreIds[0]} --- ${genre.id}");*/
                            for (var index = 0; index < 3; index++) {
                              if (film.genreIds[index] == genre.id) {
                                names.add(genre.name);
                              }
                            }
                          }
                          return Stack(children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    FlatButton(
                                      onPressed: null,
                                      textColor: Colors.white,
                                      disabledColor: Colors.white,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(names[0].toString(),
                                          style: TextStyle(color: Colors.black)),
                                    ),
                                    FlatButton(
                                      onPressed: null,
                                      textColor: Colors.white,
                                      disabledColor: Colors.white,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(names[1].toString(),
                                          style: TextStyle(color: Colors.black)),
                                    ),
                                    FlatButton(
                                      onPressed: null,
                                      textColor: Colors.white,
                                      disabledColor: Colors.white,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(names[2].toString(),
                                          style: TextStyle(color: Colors.black)),
                                    )
                                  ],
                                )

                              ],
                            )
                          ]);
                        }
                        return Text(
                          snapshot.error.toString(),
                          style: TextStyle(color: Colors.red),
                        );
                      }),
                  /* FlatButton(
                    onPressed: null,
                    textColor: Colors.white,
                    disabledColor: Colors.white,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      film == null ? show.genreIds[0].toString(): film.genreIds[0].toString(),
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    textColor: Colors.white,
                    disabledColor: Colors.white,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                        film == null ? show.genreIds[0].toString(): film.genreIds[0].toString()
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    textColor: Colors.white,
                    disabledColor: Colors.white,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                        film == null ? show.genreIds[0].toString(): film.genreIds[0].toString()
                    ),
                  )*/
                ]),
            Row(children: <Widget>[
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Cast :',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: film == null ? show.overview : film.overview),
                    ],
                  ),
                ),
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20.0, 0, 0),
                  child: Text("Summary",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: film == null ? show.overview : film.overview),
                      ],
                    ),
                  ),
                )
              ],
            )
          ]),
        ]),
      ]),
    );
  }
}
