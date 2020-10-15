import 'package:flutter/material.dart';
import 'package:flutter_app/model/Film.dart';

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

class Detail extends StatelessWidget {
  final Result film;

   Detail({Key key, this.film}) : super(key: key);

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
                          image: NetworkImage("http://image.tmdb.org/t/p/w1280/${film.posterPath}"),
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
                   film.title,
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
                    film.popularity.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    film.releaseDate.year.toString(),
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
                    film.popularity.toString(),
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
                  FlatButton(
                    onPressed: null,
                    textColor: Colors.white,
                    disabledColor: Colors.white,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      film.genreIds[0].toString(),
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    textColor: Colors.white,
                    disabledColor: Colors.white,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      film.genreIds[0].toString(),
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    textColor: Colors.white,
                    disabledColor: Colors.white,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      film.genreIds[0].toString(),
                    ),
                  )
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
                          text: film.overview),
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
                            text: film.overview),
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