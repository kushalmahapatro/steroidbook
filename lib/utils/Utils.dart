import 'package:flutter/material.dart';
export 'PreferenceManager.dart';

class Utils {
  static void snackBar(String message, BuildContext _scaffoldContext) {
    Scaffold.of(_scaffoldContext)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

// The check whether the email id is valid or not
  static bool isValidMail(String email2) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email2);
  }
}
