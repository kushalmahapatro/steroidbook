import 'package:flutter/material.dart';

void snackBar(String message, BuildContext _scaffoldContext) {
Scaffold.of(_scaffoldContext)
    .showSnackBar(new SnackBar(content: new Text(message)));
}