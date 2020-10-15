import 'package:flutter/material.dart';
import 'package:flutter_app/listviewTemplate.dart';
import 'package:flutter_app/model/TvShows.dart';
import 'detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = "blabla";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 55, 63, 0.4),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(children: <Widget>[
        Column(
          children: [
            ListviewTemplate(title: "Popular Movie", type: "popular"),
            Column(children: [
              SizedBox(
                  height: 210,
                  child: Stack(children: <Widget>[
                    Container(
                      child: Text("Popular TV Show",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                        child: Container(
                          child: FutureBuilder<TvShows>(
                            future: fetchShows(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                        child: ListView.builder(
                                            itemCount: snapshot.data.resultsShow.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    print(snapshot.data.resultsShow[index].posterPath);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Detail(
                                                                film: null,
                                                                  show: snapshot.data.resultsShow[index])),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 250,
                                                    width: 200,
                                                    decoration: new BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "http://image.tmdb.org/t/p/w500/${snapshot.data.resultsShow[index].posterPath}"),
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
            ]),
            ListviewTemplate(title: "Top Rated Movie", type: "top_rated"),
          ],
        )
      ]),
    );
  }
}
