import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vod/screens/HomePage.dart';
import 'package:vod/screens/PlayerPage.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/MyBehaviour.dart';
import 'package:vod/utils/Utils.dart';
import 'package:vod/widgets/Buttons.dart';
import 'package:vod/widgets/DescriptionTextWidget.dart';
import 'package:vod/screens/sapphire/widgets/Episodes.dart';
import 'package:vod/widgets/Rating.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
  final HomeFeaturePageSectionDetailsModel contentDetails;
  final int heroIndex;

  MovieDetailsPage({Key key, @required this.contentDetails, this.heroIndex})
      : super(key: key);
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Scaffold scaffold;
  BuildContext _context;
  int _season, _episodeCount;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _season = 0;
    _episodeCount = 4;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    double screenWidth = MediaQuery.of(context).size.width;
    int totalEpisode = 15;

    bool multiPart = false;
    if (widget.contentDetails.contentTypesId == "3") {
      multiPart = true;
    } else if (widget.contentDetails.contentTypesId == "1" ||
        widget.contentDetails.contentTypesId == "2" ||
        widget.contentDetails.contentTypesId == "4") {
      multiPart = false;
    }

    String story =
        "A short story is a piece of prose fiction that typically can be read in one sitting and focuses on a self-contained incident or series of linked incidents, with the intent of evoking a single effect or mood, however there are many exceptions to this.";

    var season = <String>[
      'Season 1',
      'Season 2',
      'Season 3',
    ];
    Widget backgroundWidget() {
      return Hero(
          tag: widget.contentDetails.permalink + "-$widget.heroIndex",
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        this.widget.contentDetails.posterUrl.toString().trim()),
                    fit: BoxFit.cover)),
          ));
    }

    Widget gradient() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // 10% of the width, so there are ten blinds.
            colors: [
              Colors.transparent,
              appbackgroundColor,
            ],
            // transparent to black
          ),
        ),
      );
    }

    Widget logoWidget() {
      return Center(
          child: Container(
              child: InkWell(
        child: Icon(Icons.play_circle_outline, color: primaryColor, size: 60.0),
        onTap: () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (c) => new Player(
                        contentDetails: widget.contentDetails,
                      )));
//                  Utils.snackBar("Play Video", _scaffoldContext);
        },
      )));
    }

    Widget videoDetails() {
      return Container(
          margin: EdgeInsets.only(top: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "02:04:35  ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: hintColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "|  PG-13  ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: hintColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "|  2016",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: hintColor,
                  fontSize: 15.0,
                ),
              ),
            ],
          ));
    }

    Widget contentDetails() {
      return Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              widget.contentDetails.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              "Genre",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                color: hintColor,
                                fontSize: 15.0,
                              ),
                            )),
                        videoDetails(),
                      ]),
                  VodButton(
                    isCiruclar: false,
                    radious: 4.0,
                    label: "Watch Trailer",
                    buttonColor: primaryColor,
                    textColor: Colors.white,
                    onClicked: () {},
                  )
                ],
              )));
    }

    Widget favourite() {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.favorite_border,
              color: primaryColor,
              size: 30.0,
            ),
          ));
    }

    Widget bannerSection() {
      return Container(
          color: appbackgroundColor,
          height: (900 / (1600 / screenWidth)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              backgroundWidget(),
              gradient(),
              favourite(),
              multiPart ? new Container() : logoWidget(),
            ],
          ));
    }

    Widget rating() {
      return Padding(
        padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
        child: StarRating(
          color: primaryColor,
          starCount: 5,
          size: 24.0,
          rating: 3,
          borderColor: primaryColor,
        ),
      );
    }

    Widget storySection() {
      return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: DescriptionTextWidget(
          text: story,
          textStyle: new TextStyle(
            color: hintColor,
            fontSize: 15.0,
          ),
        ),
      );
    }

    Widget castCrewButton() {
      return Row(
        children: <Widget>[
          VodButton(
            textColor: primaryColor,
            buttonColor: Colors.transparent,
            label: "Cast & Crew",
            isCiruclar: false,
            onClicked: () {
              Utils.snackBar("Cast and Crew", _context);
            },
          )
        ],
      );
    }

    // Multipart
    Widget dropDown() {
      return Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: DropdownButtonHideUnderline(
              child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),
                  child: DropdownButton<String>(
                    style: TextStyle(color: primaryColor),
                    value: season[_season],
                    isExpanded: true,
                    dropDownIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: primaryColor,
                    ),
                    items: season.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                            child: Text(
                          value,
                          style: TextStyle(color: primaryColor),
                        )),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _season = season.indexOf(newValue);
                        _episodeCount = 4;
                      });
                    },
                  ))));
    }

    Widget episodeList() {
      return Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) => new VodEpisodes(
                  isVertical: false,
                  image: NetworkImage(
                      "https://static.posters.cz/image/750/posters/the-avengers-age-of-ultron-team-i27856.jpg"),
                  duration: "45 mins",
                  episodeName: "The New Episode",
                  seasonName: i + 1 >= 10
                      ? "S" +
                          ((_season + 1).toString()) +
                          " : E" +
                          (i + 1).toString()
                      : "S0" +
                          ((_season + 1).toString()) +
                          ": E" +
                          (i + 1).toString(),
                  showDownload: true,
                ),
            itemCount: _episodeCount,
          ));
    }

    Widget moreButton() {
      return Center(
        child: VodButton(
          onClicked: () {
            if (_episodeCount < totalEpisode) {
              setState(() {
                _episodeCount = _episodeCount + 3;
              });
            }
          },
          isCiruclar: false,
          buttonColor: Colors.transparent,
          label: "More",
          textColor: primaryColor,
        ),
      );
    }

    Widget scrollToTop() {
      return Center(
          child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: primaryColor,
              ),
              onPressed: () {
                _scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              }));
    }

    singlePartWidgets() {
      List<Widget> widgets = new List<Widget>();
      widgets.add(bannerSection());
      widgets.add(contentDetails());
      widgets.add(rating());
      widgets.add(storySection());
      widgets.add(castCrewButton());
      return widgets;
    }

    multipartWidgets() {
      List<Widget> widgets = singlePartWidgets();
      widgets.add(dropDown());
      widgets.add(episodeList());
      _episodeCount < totalEpisode
          ? widgets.add(moreButton())
          : widgets.add(scrollToTop());
      return widgets;
    }

    Widget body = WillPopScope(
        child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              children: multiPart ? multipartWidgets() : singlePartWidgets(),
            )),
        onWillPop: () {
          Navigator.pop(context);
        });

    List<Icon> icons = new List<Icon>();
    icons.add(Utils.searchIcon);
    icons.add(Utils.notificationIcon);

    List<Function> click = new List<Function>();
    click.add(() {
      Utils.snackBar("Search", _context);
    });
    click.add(() {
      Utils.snackBar("Notification", _context);
    });

    scaffold = new Scaffold(
        appBar: Utils.buildBar(context, "Sapphire", icons, click),
        backgroundColor: Colors.black,
        body: Builder(builder: (BuildContext _buildContext) {
          _context = _buildContext;
          return body;
        }));

    return scaffold;
  }
}
