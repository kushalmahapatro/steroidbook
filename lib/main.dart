import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/ColorSwatch.dart';
import 'screens/SplashScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black.withOpacity(0.0)));
    return new MaterialApp(
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
