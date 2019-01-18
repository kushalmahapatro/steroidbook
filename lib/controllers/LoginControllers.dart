import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LoginController {
  final LoginListener listener;
  final TextEditingController emailController;
  final FocusNode emailNode;
  final TextEditingController passwordController;
  final FocusNode passwordNode;
  bool passwordObscure;
  Icon obscureIcon;

  LoginController({@required this.listener})
      : emailController = TextEditingController(),
        emailNode = FocusNode(),
        passwordController = TextEditingController(),
        passwordNode = FocusNode();

}


abstract class LoginListener {
  void onFailure();

  void onLoginSuccess();
}
