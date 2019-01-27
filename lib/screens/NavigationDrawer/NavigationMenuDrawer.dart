import 'package:flutter/material.dart';
import 'package:vod/screens/ContentListingPage.dart';
import 'package:vod/screens/HomePage.dart';
import 'package:vod/screens/NavigationDrawer/DrawerItem.dart';
import 'package:vod/screens/SettingsPage.dart';
import 'package:vod/sdk/api/GetAppMenu.dart';
import 'package:vod/utils/ColorSwatch.dart';

class NavigationMenuDrawer extends StatefulWidget {
  final GetAppMenuModel drawerPageData;

  NavigationMenuDrawer({@required this.drawerPageData});

  @override
  _NavigationMenuDrawerState createState() => _NavigationMenuDrawerState();
}

class _NavigationMenuDrawerState extends State<NavigationMenuDrawer> {
  int _selectedIndex = 0;
  Icon trailing_more = Icon(
    Icons.expand_more,
    color: textColor,
  );
  Icon trailing_less = Icon(
    Icons.expand_less,
    color: textColor,
  );

  @override
  Widget build(BuildContext context) {
    List drawerItems = new List();
    getDrawerItemScreen(int pos, String permalink, String title) {
      if (pos == 0) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext c) => HomePage()));
      } else if (pos == drawerItems.length - 1) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext c) => HomePage()));
      } else if (pos == drawerItems.length - 2) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext c) => SettingsPage()));
      } else {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext c) => ContentListingPage(
              appBarTitle: title,
              permalink: permalink,
            )));
      }
    }

    _onSelectItem(int index, String permalink, String title) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.of(context).pop();
      getDrawerItemScreen(_selectedIndex, permalink, title);
// close the drawer
    }

    drawerItems.add(DrawerItem("Home", null, false, false));
    for (int i = 0; i < widget.drawerPageData.menuItems.length; i++) {
      if (widget.drawerPageData.menuItems[i].linkType == "0") {
        drawerItems.add(DrawerItem(
            widget.drawerPageData.menuItems[i].title,
            null,
            widget.drawerPageData.menuItems[i].child.length > 0 ? true : false,
            false));
      }
    }
    drawerItems.add(DrawerItem("Settings", null, false, false));
    drawerItems.add(DrawerItem("Contact Us", null, false, false));

    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(d.hasChild
          ? new ExpansionTile(
              title: new Text(
                d.title,
                style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ),
              trailing: d.expanded ? trailing_less : trailing_more,
              onExpansionChanged: (value) {
                setState(() => value ? d.expanded = true : d.expanded = false);
              },
              children: widget.drawerPageData.menuItems[i - 1].child
                  .map((val) => new ListTile(
                        leading: new Icon(null),
                        title: new Text(
                          val.title,
                          style:
                              new TextStyle(fontSize: 14.0, color: textColor),
                        ),
                        selected: i == _selectedIndex,
                        onTap: () => _onSelectItem(i, val.permalink, val.title),
                      ))
                  .toList(),
            )
          : new ListTile(
              title: new Text(
                d.title,
                style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ),
              selected: i == _selectedIndex,
              onTap: () => _onSelectItem(
                  i,
                  widget.drawerPageData.menuItems[i-1].permalink,
                  widget.drawerPageData.menuItems[i-1].title),
            ));
    }
    return Drawer(
      elevation: 16.0,
      child: Container(
          color: appbackgroundColor,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Container(
                child: Center(
                  child: Image.asset("assets/images/sapphire_logo.png",
                      width: 160.0, height: 160.0),
                ),
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                height: 200.0,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: drawerOptions),
            ],
          )),
    );
  }
}
