import 'package:flutter/material.dart';
import 'package:vod/screens/HomePage.dart';
import 'package:vod/screens/NavigationDrawer/DrawerItem.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Utils.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Icon trailing_more = Icon(Icons.expand_more,color: textColor,);
  Icon trailing_less = Icon(Icons.expand_less,color: textColor,);



  final drawerItems = [
    new DrawerItem("Home", null, false, false),
    new DrawerItem("Pizza", null, true, false),
    new DrawerItem("Coffee", null, true, false),
  ];

  _getDrawerItemScreen(int pos) {
    if (pos == 0)
      return new HomePage(/*drawerItem: drawerItems[_selectedIndex]*/);
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _getDrawerItemScreen(_selectedIndex);
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(d.hasChild
          ? new ExpansionTile(
              title: new Text(
                d.title,
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: textColor),
              ),
              trailing: d.expanded ? trailing_less : trailing_more,
              onExpansionChanged: (value){
                setState(() => value? d.expanded = true : d.expanded = false);
              },
              children: drawerItems
                  .map((val) => new ListTile(
                        leading: new Icon(val.icon),
                        title: new Text(
                          val.title,
                          style: new TextStyle(fontSize: 14.0, color: textColor),
                        ),
                        selected: i == _selectedIndex,
                        onTap: () => _onSelectItem(i),
                      ))
                  .toList(),
            )
          : new ListTile(
              title: new Text(
                d.title,
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: textColor),
              ),
              selected: i == _selectedIndex,
              onTap: () => _onSelectItem(i),
            ));
    }
    List<Icon> icons = new List<Icon>();
    icons.add(Utils.searchIcon);
    icons.add(Utils.notificationIcon);

    List<Function> click = new List<Function>();
    click.add(() {
      Utils.snackBar("Search", context);
    });
    click.add(() {
      Utils.snackBar("Notification", context);
    });
    return new Scaffold(
      appBar: Utils.buildBar(context, "Sapphire", icons, click),
      drawer: new Drawer(
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
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  height: 200.0,
                ), Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: drawerOptions),
              ],
            )),
      ),
      body: _getDrawerItemScreen(_selectedIndex),
    );
  }
}
