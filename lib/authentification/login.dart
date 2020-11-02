import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';

class ConnexionPage extends StatefulWidget {
  ConnexionPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  void _register() async {
    try {
      final FirebaseUser user = (await
      _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
      ).user;
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
      } else {
        setState(() {
          _success = true;

        });
      }
    } catch(signUpError) {
      if(signUpError is PlatformException) {
        if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          final FirebaseUser user = (await
          _auth.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          )
          ).user;
        }
      }
    }
  }

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
                  TextBoxWidget("Username", "Error in the username", _emailController, false),
                  SizedBox(height: 20),
                  TextBoxWidget("Password", "Error in the password", _passwordController, true),
                  SizedBox(height: 20),
                  RaisedButton(
                      highlightColor: Colors.red,
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text('Join the Films list is impossible without correct identifiers')));
                        }
                        else{
                          _register();
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
  TextBoxWidget(this.hintText, this.errorText, this._controller, this.isPasswordField);

  @override
  _TextBoxWidgetState createState() => _TextBoxWidgetState();

  final String hintText;
  final String errorText;
  final TextEditingController _controller;
  final bool isPasswordField;
}

class _TextBoxWidgetState extends State<TextBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: widget.isPasswordField,
        controller: widget._controller,
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
          } else if(!widget.isPasswordField) {
            return EmailValidator.validate(value) ? null : "Please enter a valid email";
          }
          return null;
        },
      ),
    );
  }
}
