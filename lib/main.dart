import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/tv_show.dart';
import 'package:flutter_app/template/list_view_template.dart';
import 'screen/detail.dart';
import 'authentification/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        //splash: Image.asset('assets/images/animation.gif'),
        splash: Image.network(
            "https://media1.tenor.com/images/1fe36998add400322db6aae8612d3fcf/tenor.gif?itemid=15122473"),
        nextScreen: ConnexionPage(title: 'Flutter Demo Home Page'),
        //splashTransition: SplashTransition.sizeTransition,
        backgroundColor: Colors.black,
        splashIconSize: 500,
      ),
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,

      appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConnexionPage()),
                );
              },
            )
          ],
        leading: IconButton(
        icon: Icon(Icons.home, color: Colors.white)
        ),
          backgroundColor: Colors.black,
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              "assets/images/amaflix.png",
              fit: BoxFit.contain,
              height: 20,
            )
          ])),

      body: Stack(children: <Widget>[
        ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Column(
              children: [
                ListviewTemplate(title: "Popular Movie", type: "popular"),
                SizedBox(height: 20),
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
                            padding: EdgeInsets.fromLTRB(0, 35, 0, 5),
                            child: Container(
                              child: FutureBuilder<TvShows>(
                                future: fetchShows(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        child: ListView.builder(
                                            itemCount: snapshot
                                                .data.resultsShow.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Detail(
                                                                  film: null,
                                                                  show: snapshot
                                                                          .data
                                                                          .resultsShow[
                                                                      index])),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 250,
                                                    width: 150,
                                                    decoration:
                                                        new BoxDecoration(
                                                            image:
                                                                DecorationImage(
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
                SizedBox(height: 20),
                ListviewTemplate(title: "Top Rated Movie", type: "top_rated"),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
