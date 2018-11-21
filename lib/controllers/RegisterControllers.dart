import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RegisterController {
  final RegisterListener listener;
  final TextEditingController emailController;
  final FocusNode emailNode;
  final TextEditingController nameController;
  final FocusNode nameNode;
  final TextEditingController phoneController;
  final FocusNode phoneNode;
  final TextEditingController passwordController;
  final FocusNode passwordNode;
  final TextEditingController confirmPasswordController;
  final FocusNode confirmPasswordNode;
  bool passwordObscure;
  bool confirmPasswordObscure;
  Icon obscureIcon;
  Icon confirmObscureIcon;

  RegisterController({@required this.listener})
      : emailController = TextEditingController(),
        emailNode = FocusNode(),
        nameController = TextEditingController(),
        nameNode = FocusNode(),
        phoneController = TextEditingController(),
        phoneNode = FocusNode(),
        confirmPasswordController = TextEditingController(),
        confirmPasswordNode = FocusNode(),
        passwordController = TextEditingController(),
        passwordNode =  FocusNode();
}

abstract class RegisterListener {
  void onFailure();

  void onRegisterSuccess();
}
