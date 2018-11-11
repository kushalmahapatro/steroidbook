import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/controllers/SplashScreenController.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    implements SplashScreenListener {
  SplashScreenController controller;

  _SplashScreenState() {
    controller = SplashScreenController(listener: this);
  }

  @override
  Widget build(BuildContext context) {
    controller.callApi();
    return Scaffold(
        primary: false,
        body: new Container(
          color: primaryColor,
          padding: EdgeInsets.only(top: 0.0),
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[backgroundWidget(), logoWidget()],
          ),
        ));
  }

  Widget backgroundWidget() {
    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    ));
  }

  Widget logoWidget() {
    return Center(
      child: Image.asset(
        "assets/images/logo.png",
        width: 120.0,
        height: 120.0,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void onApiFailure({@required Failures failure}) {
    switch (failure) {
      case Failures.NO_INTERNET:
        break;

      default:
        break;
    }
  }

  @override
  void routeTo({@required Routes route}) {
    switch (route) {
      case Routes.LOGIN:
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (c) => new Login()));
        break;

      default:
        break;
    }
  }
}
