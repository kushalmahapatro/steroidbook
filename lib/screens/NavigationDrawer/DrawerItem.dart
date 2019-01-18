import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  bool hasChild;
  bool expanded;

  DrawerItem(this.title, this.icon, this.hasChild, this.expanded);
}
