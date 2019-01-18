import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vod/controllers/LoginControllers.dart';
import 'package:vod/controllers/RegisterControllers.dart';
import 'package:vod/screens/HomePage.dart';
import 'package:vod/screens/Register.dart';
import 'package:vod/screens/sapphire/Login.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/utils/MyBehaviour.dart';
import 'package:vod/widgets/Buttons.dart';
import 'package:vod/widgets/TextFields.dart';
import 'package:vod/utils/Utils.dart';

class Register extends StatefulWidget {
  final bool isSplash;

  Register({Key key, @required this.isSplash}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements RegisterListener {
  RegisterController controller;
  Scaffold scaffold;
  BuildContext _scaffoldContext;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();
  final nameController = new TextEditingController();
  final phoneController = new TextEditingController();

  _RegisterState() {
    controller = RegisterController(listener: this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    validator() {
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
            Utils.snackBar(
                "The password should be minimum 6 digits", _scaffoldContext);
          }
        } else {
          Utils.snackBar("Please enter valid email address", _scaffoldContext);
        }
      }
    }

    Widget RegisterButton = VodButton(
        buttonColor: primaryColor,
        height: BUTTON_HEIGHT,
        label: "Register",
        radious: 2.0,
        onClicked: () {
          validator();
        });

    Widget facebookButton = VodButton(
        isCiruclar: true,
        buttonColor: facebookButtonColor,
        height: BUTTON_HEIGHT,
        width: BUTTON_HEIGHT,
        radious: BUTTON_HEIGHT / 2,
        imageAsset: "assets/images/facebook.png",
        onClicked: () {
          Utils.snackBar("Login with Facebook", _scaffoldContext);
        });

    Widget googleButton = VodButton(
        isCiruclar: true,
        buttonColor: googleButtonColor,
        height: BUTTON_HEIGHT,
        width: BUTTON_HEIGHT,
        radious: BUTTON_HEIGHT / 2,
        imageAsset: "assets/images/google.png",
        onClicked: () {
          Utils.snackBar("Login with Google", _scaffoldContext);
        });

    Widget loginView = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            "Already have an account ? ",
            style: new TextStyle(color: hintColor),
          ),
        ),
        new InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed('/Register');
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (c) => new Login(
                            isSplash: widget.isSplash,
                          )));
              //  Utils.snackBar("Login", _scaffoldContext);
            },
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Text("Login",
                    style: new TextStyle(color: primaryColor)))),
      ],
    );

    Widget body = Container(
        color: appbackgroundColor,
        padding: EdgeInsets.only(top: 0.0),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: Center(
                  child: ListView(
                padding: EdgeInsets.all(30.0),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Center(
                      child: Container(
                        child: Center(
                          child: Image.asset("assets/images/sapphire_logo.png",
                              width: 150.0, height: 150.0),
                        ),
                      ),
                    ),
                  ),
                  new VodTextField(
                    activeColor: primaryColor,
                    inActiveColor: hintColor,
                    label: "Name",
                    hintText: "Enter your name",
                    inputType: TextInputType.text,
                    editingController: nameController,
                  ),

                  new VodTextField(
                    activeColor: primaryColor,
                    inActiveColor: hintColor,
                    label: "Email",
                    hintText: "Enter your email",
                    inputType: TextInputType.emailAddress,
                    editingController: emailController,
                  ),

                  // Password field
                  PHONE_NUMBER_REGISTERATION == 1
                      ? new VodTextField(
                          activeColor: primaryColor,
                          inActiveColor: hintColor,
                          label: "Phone",
                          hintText: "Enter your phone number",
                          editingController: phoneController,
                        )
                      : Container(),

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
                  new VodTextField(
                    activeColor: primaryColor,
                    inActiveColor: hintColor,
                    label: "Confirm Password",
                    hintText: "Re Enter your password",
                    obscureText: true,
                    suffixIcon: Icon(Icons.visibility),
                    obscureToggle: true,
                    obscureIcon: Icon(Icons.visibility_off),
                    editingController: confirmPasswordController,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "I am over 18 and agree to ",
                          style: TextStyle(color: Colors.white),
                        ),
                        InkWell(
                          child: Text(
                            "Terms",
                            style: TextStyle(color: primaryColor),
                          ),
                          onTap: () {
                            Utils.snackBar(
                                "Terms and Conditions", _scaffoldContext);
                          },
                        )
                      ],
                    )),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: RegisterButton),

                  Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 1.0,
                            width: 90.0,
                            color: Colors.white,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            height: 1.0,
                            width: 90.0,
                            color: Colors.white,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                        ],
                      ))),

                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FACEBOOK_LOGIN == 1 ? facebookButton : Container(),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(),
                        ),
                        GOOGLE_LOGIN == 1 ? googleButton : Container(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: loginView)
                ],
              )),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0, right: 10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: hintColor,
                      ),
                      onPressed: () {
                        if (Platform.isIOS)
                          exit(0);
                        else
                          SystemNavigator.pop();
                      },
                    ))),
          ],
        ));

    scaffold = new Scaffold(
      body: Builder(builder: (BuildContext _context) {
        _scaffoldContext = _context;
        return body;
      }),
    );

    return scaffold;
  }

  @override
  void onFailure() {}

  @override
  void onRegisterSuccess() {
    // TODO: implement onRegisterSuccess
  }
}
