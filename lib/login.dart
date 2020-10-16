import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class ConnexionPage extends StatefulWidget {
  ConnexionPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: new AppBar(backgroundColor: Colors.transparent),
      body: Column(children: <Widget>[
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                "assets/images/login.png",
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.bottomCenter * 0.6,
                    colors: [
                      Colors.black,
                      Colors.black54,
                      Colors.black12,
                      Colors.transparent
                    ],
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextBoxWidget("Username", "Error in the username"),
                  SizedBox(height: 20),
                  TextBoxWidget("Password", "Error in the password"),
                  SizedBox(height: 20),
                  RaisedButton(
                      highlightColor: Colors.red,
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Join the Films list is impossible without correct identifiers')));
                        }
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        }
                      },
                      child: Text("Login"))
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class TextBoxWidget extends StatefulWidget {
  TextBoxWidget(this.hintText, this.errorText);

  @override
  _TextBoxWidgetState createState() => _TextBoxWidgetState();

  final String hintText;
  final String errorText;
}

class _TextBoxWidgetState extends State<TextBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontSize: 15,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return widget.errorText;
          }
          return null;
        },
      ),
    );
  }
}
