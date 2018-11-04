import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/clippers/TopCircleClipper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: EdgeInsets.only(top: 0.0),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            Stack(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
                child: ClipPath(
                  child: Container(
                    padding: EdgeInsets.only(top: 70.0, bottom: 20.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(decoration: InputDecoration(hintText: "Email"),),
                        TextField(decoration: InputDecoration(hintText: "Password"),),
                      ],
                    ),
                  ),
                  clipper: TopCircleClipper(),
                ),
              ),
              Padding (
                padding: EdgeInsets.only(top: 26.0),
                child: Center(
                  child: Container(
                    width: 108.0, height: 108.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black
                    ),
                    child: Center(child: Image.asset("assets/images/logo.png", width: 70.0, height: 70.0),),
                  ),
                ),
              ),
            ],)
          ],
        )
      ),
    );
  }
}
