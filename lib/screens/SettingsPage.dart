import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Utils.dart';

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Scaffold scaffold;
  BuildContext _context;
  List<String> title = new List();
  List<String> subtitle = new List();
  List<bool> hasSwitch = new List();
  String userName = "";
  final PreferenceManager preferenceManager = PreferenceManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserName();
    title.add("Stream");
    title.add("Download");
    title.add("Notification");
    title.add("Manage Devices");
    title.add("Clear Watch History");
    title.add("Profile");
    title.add("Signed in as");
    title.add("Language");

    subtitle.add("manage Streaming Settings");
    subtitle.add("manage Download Settings");
    subtitle.add("off");
    subtitle.add("See all registered Devices");
    subtitle.add("");
    subtitle.add("Edit");
    subtitle.add("");
    subtitle.add("English");

    hasSwitch.add(false);
    hasSwitch.add(false);
    hasSwitch.add(true);
    hasSwitch.add(false);
    hasSwitch.add(false);
    hasSwitch.add(false);
    hasSwitch.add(false);
    hasSwitch.add(false);
  }

  _getUserName() async {
    setState(() {
      userName = preferenceManager.getUserName() as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool switchValue = false;
    Widget settingsItem(String title, String subtitle, bool sw, bool last,
        int index) =>
        GestureDetector(
            onTap: () {
              if (index == 6) {
                showDialog(context: _context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Are you sure you want to Logout?"),
                    actions: <Widget>[
                      FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      FlatButton(
                          child: Text('yes'),
                          onPressed: () {
                            preferenceManager.clearPreferences();
                            Navigator.of(context).pop();
                          })
                    ],
                  );
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(5.0),
              color: appbackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(index == 6 ?
                              title : title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              Text(
                                subtitle,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                              ),
                            ],
                          ),
                          sw
                              ? Center(
                            child: Switch(
                              value: switchValue,
                              onChanged: (bool) {
                                setState(() {
                                  switchValue = true;
                                });
                              },
                              activeColor: primaryColor,
                              inactiveThumbColor: Colors.grey,
                              activeTrackColor: primaryColor,
                              inactiveTrackColor: Colors.grey,
                              materialTapTargetSize:
                              MaterialTapTargetSize.padded,
                            ),
                          )
                              : Container(),
                        ],
                      )),
                  !last
                      ? Container(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20.0),
                    height: 1.0,
                    color: primaryColor,
                  )
                      : Container()
                ],
              ),
            ));

    Widget body = ListView.builder(
        itemCount: title.length,
        itemBuilder: (content, index) {
          if (index == title.length - 1) {
            return settingsItem(
                title[index], subtitle[index], hasSwitch[index], true, index);
          } else {
            return settingsItem(
                title[index], subtitle[index], hasSwitch[index], false, index);
          }
        });

    scaffold = new Scaffold(
        appBar: Utils.buildBar(context, "Settings", null, null),
        backgroundColor: Colors.black,
        body: Builder(builder: (BuildContext _buildContext) {
          _context = _buildContext;
          return body;
        }));
    return scaffold;
  }
}

class settingsList {
  final String title;
  final String subTitle;
  final bool hasSwitch;

  settingsList({this.title, this.subTitle, this.hasSwitch});
}
