import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vod/controllers/LoginControllers.dart';
import 'package:vod/screens/HomePage.dart';
import 'package:vod/screens/Register.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/clippers/TopCircleClipper.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/utils/MyBehaviour.dart';
import 'package:vod/widgets/Buttons.dart';
import 'package:vod/widgets/TextFields.dart';
import 'package:vod/utils/Utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginListener {
  LoginController controller;
  Scaffold scaffold;
  BuildContext _scaffoldContext;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  _LoginState() {
    controller = LoginController(listener: this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget forgotPassword = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new InkWell(
            onTap: () {
              //    Navigator.of(context).pushNamed('/Register');
              Utils.snackBar("Forgot Password", _scaffoldContext);
            },
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: new Text("Forgot Password ?",
                    style: new TextStyle(color: primaryColor)))),
      ],
    );

    validator(){
      if (emailController.text.isEmpty) {
        Utils.snackBar("Please enter Email Address", _scaffoldContext);
      } else if (passwordController.text.isEmpty) {
        Utils.snackBar("Please enter the password", _scaffoldContext);
      } else {
        if (Utils.isValidMail(emailController.text)) {
          if (passwordController.text.length >= 6) {
            // Loigin API to be called over here
            Utils.snackBar("Login Api Call", _scaffoldContext);
          } else {
            Utils.snackBar("The password should be minimum 6 digits",
                _scaffoldContext);
          }
        } else {
          Utils.snackBar(
              "Please enter valid email address", _scaffoldContext);
        }
      }
    }

    Widget loginButton = VodButton(
        buttonColor: primaryColor,
        label: "Login",
        onClicked: () {
//         validator();
          Navigator.pushReplacement(
              context, new MaterialPageRoute(builder: (c) => new HomePage()));
        });

    Widget facebookButton = VodButton(
        buttonColor: Color.fromARGB(255, 59, 89, 152),
        label: "Login with Facebook",
        imageAsset: "assets/images/facebook.png" ,
        onClicked: () {
          Utils.snackBar("Login with Facebook", _scaffoldContext);
        });

    Widget googleButton = VodButton(
        buttonColor: Color.fromARGB(255, 221, 75, 57),
        label: "Login with Google",
        imageAsset: "assets/images/google.png" ,
        onClicked: () {
          Utils.snackBar("Login with Google", _scaffoldContext);
        });



    Widget signupView = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            "New User? ",
            style: new TextStyle(color: Colors.black),
          ),
        ),
        new InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed('/Register');
              Navigator.push(
                  context, new MaterialPageRoute(builder: (c) => new Register()));
            //  Utils.snackBar("Register", _scaffoldContext);
            },
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Text("Register",
                    style: new TextStyle(color: primaryColor)))),
      ],
    );

    Widget body = Container(
      decoration: getBlurredImage(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: BLUR_SIGMA, sigmaY: BLUR_SIGMA),
        child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            padding: EdgeInsets.only(top: 0.0),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 80.0, left: 20.0, right: 20.0, bottom: 80.0),
                          child: ClipPath(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 70.0,
                                  bottom: 20.0,
                                  left: 20.0,
                                  right: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new VodTextField(
                                    activeColor: primaryColor,
                                    inActiveColor: hintColor,
                                    label: "Email",
                                    hintText: "Enter your email",
                                    inputType: TextInputType.emailAddress,
                                    editingController: emailController,
                                  ),
                                  new VodTextField(
                                    activeColor: primaryColor,
                                    inActiveColor: hintColor,
                                    label: "Password",
                                    hintText: "Enter your password",
                                    obscureText: true,
                                    suffixIcon: Icon(Icons.visibility),
                                    obscureToggle: true,
                                    obscureIcon: Icon(Icons.visibility_off),
                                    editingController: passwordController,
                                  ),

                                  //Forgot password text
                                  Padding(padding: EdgeInsets.only(top: 16.0, bottom: 8.0), child: forgotPassword),

                                  // Login Button
                                  Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0), child: loginButton),

                                  // New User Signup Text
                                  Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0), child: signupView),

                                  // Facebook Button
                                  FACEBOOK_LOGIN == 1 ?
                                  Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0), child: facebookButton) : Container(),

                                  // Google Button
                                  GOOGLE_LOGIN == 1 ?
                                  Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0), child: googleButton) : Container(),

                                ],
                              ),
                            ),
                            clipper: TopCircleClipper(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 26.0),
                          child: Center(
                            child: Container(
                              width: 108.0,
                              height: 108.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black, backgroundBlendMode: BlendMode.overlay),
                              child: Center(
                                child: Image.asset("assets/images/logo.png",
                                    width: 90.0, height: 90.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ))),
      ),
    );

    scaffold = new Scaffold(
      body: Builder(builder: (BuildContext _context) {
        _scaffoldContext = _context;
        return body;
      }),
    );

    return scaffold;
  }

  BoxDecoration getBlurredImage() {
    if (IMAGE_BACKGROUND) {
      return BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover));
    } else {
      return BoxDecoration(color: primaryColor);
    }
  }

  @override
  void onFailure() {}

  @override
  void onLoginSuccess() {}
}
