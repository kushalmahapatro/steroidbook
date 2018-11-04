import 'package:flutter/material.dart';

class TopCircleClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo((size.width/2)-60.0, 0.0);

    //Center Circle path
    path.arcToPoint(
      Offset((size.width/2)+60.0, 0.0),
      clockwise: false,
      radius: Radius.circular(60.0),
      largeArc: true
    );

    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}