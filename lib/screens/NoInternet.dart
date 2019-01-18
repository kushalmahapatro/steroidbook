import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/widgets/Buttons.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  String _animation = "gone";
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: appbackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: screenWidth,
                  height: screenWidth,
                  child: FlareActor(
                    "assets/flares/noInternetConnection.flr",
                    animation: _animation,
                    color: primaryColor,
                    callback: (string) {
                      setState(() {
                        isAnimating = false;
                        debugPrint(string);
                      });

                    },
                  )),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    "Oops trouble connecting to the internet, Please check the network connections in this device.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor, fontSize: 15.0)),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                          child: Text("Retry"),
                          textColor: appbackgroundColor,
                          color: primaryColor,
                          onPressed: () {
                            setState(() {
                              isAnimating = true;
                              _animation = "gone";
                            });
                          },
                        ))
            ],
          ),
        ));
  }
}
