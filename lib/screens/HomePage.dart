import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vod/controllers/HomePageControllers.dart';
import 'package:vod/screens/NavigationDrawer/Drawer.dart';
import 'package:vod/screens/NavigationDrawer/NavigationMenuDrawer.dart';
import 'package:vod/screens/Shimmer/HomePageShimmer.dart';
import 'package:vod/screens/sapphire/MovieDetailsPage.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
import 'package:vod/sdk/api/GetAppMenu.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/utils/MyBehaviour.dart';
import 'package:vod/utils/Utils.dart';
import 'package:vod/widgets/Carousel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vod/widgets/ColorLoader.dart';
import 'package:vod/widgets/FeatureContent.dart';
import 'package:vod/widgets/FeatureSection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomePageListener {
  HomePageController controller;
  bool apiFetched = false;

  _HomePageState() {
    controller = HomePageController(listener: this);
    controller.callApi();
  }

  GetAppHomeFeatureModel homePageData;
  GetAppMenuModel drawerPageData;

  Scaffold scaffold;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    double screenWidth = MediaQuery.of(context).size.width;

    List bannerImages() {
      List image = new List();
      for (int i = 0; i < homePageData.bannerSectionList.length; i++) {
        image.add(NetworkImage(
            homePageData.bannerSectionList[i].imagePath.toString().trim()));
      }
      return image;
    }

    Future<ui.Image> _getImage(String url) {
      try {
        Completer<ui.Image> completer = new Completer<ui.Image>();
        new NetworkImage(url).resolve(new ImageConfiguration()).addListener(
                (ImageInfo info, bool _) => completer.complete(info.image));
        return completer.future;
      }catch(e){
        return null;
      }
    }

    horizontalList(bool isVertical, HomeFeaturePageSectionModel section) {
      return Container(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: section.data.length >= SECTION_CONTENT_LIMIT
                ? SECTION_CONTENT_LIMIT
                : section.data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: FeatureContent(
                      gradientEndColor: Colors.transparent,
                      image: NetworkImage(
                          section.data[index].posterUrl.toString().trim()),
                      /*title: section.data[index].name
                  .toString()
                  .trim(),*/
                      isVertical: isVertical,
                      onClicked: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext c) {
                          return MovieDetailsPage(
                            contentDetails: section.data[index],
                          );
                        }));
                      }));
            }),
        height: isVertical ? VR_HEIGHT : HR_HEIGHT,
      );
    }

    Widget body =
      apiFetched ?
        new Container(
            child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 100.0),
                itemCount: homePageData.sectionName.length + 2,
                itemBuilder: (BuildContext ctxt, int index) {
                  if (index == 0) {
                    return new SizedBox(
                        height: 900 / (1600 / screenWidth),
                        child: new Carousel(
                          autoplay: true,
                          dotBgColor: Colors.transparent,
                          dotColor: Colors.white,
                          noRadiusForIndicator: true,
                          dotSize: 5,
                          isDynamic: true,
                          images: [
                            bannerImages(),
                          ],
                        ));
                  } else if (index == 1) {
                    return new Container(
                      height: 1,
                      color: primaryColor,
                    );
                  } else {
                    if (homePageData.sectionName[index - 2].sectionType ==
                        "0" && homePageData.sectionName[index - 2].data.length > 0) {
                      return new Container(
                        child: new FutureBuilder<ui.Image>(
                          future: _getImage(homePageData
                              .sectionName[index - 2].data[0].posterUrl),
                          builder: (BuildContext context,
                              AsyncSnapshot<ui.Image> snapshot) {
                            if (snapshot.hasData) {
                              bool vertical;
                              if (snapshot.data.width > snapshot.data.height) {
                                vertical = false;
                              } else {
                                vertical = true;
                              }
                              return new FeatureSection(
                                section: homePageData.sectionName[index - 2],
                                isVertical: vertical,
                                buttonBgColor: Colors.transparent,
                                buttonText: "More >",
                                buttonTextColor: primaryColor,
                                onButtonPress: () {
                                  Utils.snackBar(
                                      homePageData
                                          .sectionName[index - 2].sectionId,
                                      _context);
                                },
                                child: horizontalList(vertical,
                                    homePageData.sectionName[index - 2]),
                              );
                            } else {
                              return new Container();
                            }
                          },
                        ),
                      );
                    } else {
                      return new Container();
                    }
                  }
                }),
          )):
          HomePageShimmer()
       ;

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
        drawer: apiFetched ? NavigationMenuDrawer(drawerPageData: drawerPageData,) : null,
        body: Builder(builder: (BuildContext _buildContext) {
          _context = _buildContext;
          return body;
        }));
    return scaffold;
  }

  @override
  void onApiFailure({Failures failure}) {
    // TODO: implement onApiFailure
  }

  @override
  void onApiSuccess({GetAppHomeFeatureModel homeData, GetAppMenuModel drawerData}) {
    setState(() {
      homePageData = homeData;
      drawerPageData = drawerData;
      apiFetched = true;
    });
  }
}
