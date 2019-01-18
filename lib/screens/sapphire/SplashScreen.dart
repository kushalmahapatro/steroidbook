import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vod/screens/HomePage.dart';
import 'package:vod/screens/NoInternet.dart';
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
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  _SplashScreenState() {
    controller = SplashScreenController(listener: this);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result;
          print(_connectionStatus);
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            controller.callApi();
            setState(() {});
          }
        });
  }


  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      if (_connectionStatus == ConnectivityResult.wifi ||
          _connectionStatus == ConnectivityResult.mobile) {
        return Scaffold(
            primary: false,
            body: new Container(
              color: primaryColor,
              padding: EdgeInsets.only(top: 0.0),
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[backgroundWidget(), /* logoWidget()*/
                ],
              ),
            ));
      }
      else {
        return NoInternet();
      }
    }else{
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
              children: <Widget>[backgroundWidget(), /* logoWidget()*/
              ],
            ),
          ));
    }
  }

  Widget backgroundWidget() {
    return Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash_screen.jpg"),
                  fit: BoxFit.cover)),
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
       /* Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (c) => new NoInternet()));*/
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
            context, new MaterialPageRoute(builder: (c) => new Login(isSplash: true,)));
        break;
      case Routes.HOME:
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (c) => new HomePage()));
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

}
