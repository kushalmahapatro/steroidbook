import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vod/bloc/bloc_login.dart';
import 'package:vod/screens/NavigationDrawer/Drawer.dart';
import 'package:vod/screens/sapphire/Register.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/utils/MyBehaviour.dart';
import 'package:vod/widgets/Buttons.dart';
import 'package:vod/widgets/ColorLoader.dart';
import 'package:vod/widgets/TextFields.dart';
import 'package:vod/utils/Utils.dart';

class Login extends StatefulWidget {
  final bool isSplash;

  Login({Key key, @required this.isSplash}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Scaffold scaffold;
  BuildContext _scaffoldContext;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  StreamBuilder<LoginData> _loginApi;


  @override
  void initState() {
    _loginApi = StreamBuilder<LoginData>(
      stream: blocLogin.loginApi,
      builder: (context, snapshot) {
        if(snapshot.connectionState ==  ConnectionState.active) {
          if (snapshot.hasData) {
            if (snapshot.data.success) {
              return Navigator(
                onGenerateRoute: (RouteSettings settings) {
                  return new MaterialPageRoute(
                      builder: (c) => new NavigationDrawer());
                },
                onUnknownRoute: (RouteSettings settings) {
                  throw Exception('unknown route');
                },
              );
            } else {
              Utils.displaySnackBar(
                  scaffoldState, snapshot.data.message, context);
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            Utils.displaySnackBar(
                scaffoldState, snapshot.error.toString(), context);
          }
        }
        return new Container();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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

    Widget loginButton = StreamBuilder<bool>(
        stream: blocLogin.loginClick,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data) {
            return Center(
                child: Container(
                    height: BUTTON_HEIGHT,
                    child: ColorLoaderPlain(
                      colors: loaderColors,
                      duration: Duration(milliseconds: 1200),
                    )));
          } else {
            return VodButton(
                buttonColor: primaryColor,
                label: "Login",
                radious: 2.0,
                onClicked: () {
                  blocLogin.callApi(
                      emailController.text, passwordController.text);
                });
          }
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

    Widget signupView = new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            "New User? ",
            style: new TextStyle(color: hintColor),
          ),
        ),
        new InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (c) => new Register(isSplash: widget.isSplash)));
            },
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Text("Register",
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
          overflow: Overflow.visible,
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
                  StreamBuilder<LoginData>(
                    initialData: LoginData(true, null, null),
                    stream: blocLogin.email,
                    builder: (context, snapshot) {
                      return VodTextField(
                        activeColor: primaryColor,
                        inActiveColor: hintColor,
                        enable: snapshot.data.success,
                        label: "Email",
                        error: snapshot.data.message ??= null,
                        hintText: "Enter your email",
                        inputType: TextInputType.emailAddress,
                        editingController: emailController,
                      );
                    },
                  ),

                  StreamBuilder<LoginData>(
                    initialData: LoginData(true, null, null),
                    stream: blocLogin.password,
                    builder: (context, snapshot) {
                      return  VodTextField(
                        activeColor: primaryColor,
                        inActiveColor: hintColor,
                        label: "Password",
                        enable: snapshot.data.success,
                        hintText: "Enter your password",
                        error: snapshot.data.message ??= null,
                        obscureText: true,
                        suffixIcon: Icon(Icons.visibility),
                        obscureToggle: true,
                        obscureIcon: Icon(Icons.visibility_off),
                        editingController: passwordController,
                      );
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Center(
                          child: forgotPassword,
                        ),
                        loginButton
                      ],
                    ),
                  ),
                  //Forgot password text
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
                      child: signupView)
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
                        Platform.isIOS
                            ? widget.isSplash ? exit(0) : Navigator.pop(context)
                            : SystemNavigator.pop();
                      },
                    ))),

            _loginApi,
          ],
        ));

    scaffold = new Scaffold(
      key: scaffoldState,
      body: Builder(builder: (BuildContext _context) {
        _scaffoldContext = _context;
        return body;
      }),
    );

    return scaffold;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    blocLogin.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
