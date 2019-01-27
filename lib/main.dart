import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/ColorSwatch.dart';
import 'screens/sapphire/SplashScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if(Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness
            .dark, //or set color with: Color(0xFF0000FF)
      ));
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness
            .light, //or set color with: Color(0xFF0000FF)
      ));
    }
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VOD Demo',
      theme: new ThemeData(
        primarySwatch: materialPrimary,
        textTheme: TextTheme(
          body1: TextStyle(
            inherit: true,
            fontSize: 16.0,
            color: Color(0xFF000000),
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal
          ),
        ),
      ),
      initialRoute: '/',
      routes: {'/':(c)=> SplashScreen()}, //Start the app with the "/" named route.
    );
  }
}
