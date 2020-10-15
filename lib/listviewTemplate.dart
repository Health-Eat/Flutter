import 'package:flutter/material.dart';
import 'package:flutter_app/model/Film.dart';
import 'detail.dart';

class ListviewTemplate extends StatelessWidget {
  final String title;
  final String type;
  final double size = 210;
  final baseUrl = "http://image.tmdb.org/t/p/w500";

  const ListviewTemplate({Key key, this.title, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(children: [
        SizedBox(
            height: size,
            child: Stack(children: <Widget>[
              Container(
                child: Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                  child: Container(
                        child: FutureBuilder<Film>(
                          future: fetchFilms(type),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: ListView.builder(
                                      itemCount: snapshot.data.results.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Detail(
                                                            film: snapshot.data.results[index])),
                                              );
                                            },
                                            child: Container(
                                              height: size,
                                              width: 200,
                                              decoration: new BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                    "$baseUrl/${snapshot.data.results[index].posterPath}"),
                                                fit: BoxFit.fitHeight,
                                              )),
                                            ));
                                      }));
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red));
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ))
            ]))
      ])
    ]);
  }
}
