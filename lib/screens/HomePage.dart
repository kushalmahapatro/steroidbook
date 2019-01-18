import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vod/controllers/HomePageControllers.dart';
import 'package:vod/screens/sapphire/MovieDetailsPage.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
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

  _HomePageState() {
    controller = HomePageController(listener: this);
    controller.callApi();
  }

  GetAppHomeFeatureModel homePageData;
  bool apiFetched = false;

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
      Completer<ui.Image> completer = new Completer<ui.Image>();
      new NetworkImage(url).resolve(new ImageConfiguration()).addListener(
          (ImageInfo info, bool _) => completer.complete(info.image));
      return completer.future;
    }

    horizontalList(bool isVertical, HomeFeaturePageSectionModel section) {
      return Container(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: int.parse(section.total) >= SECTION_CONTENT_LIMIT
                ? SECTION_CONTENT_LIMIT
                : int.parse(section.total),
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
                      heroTag: section.data[index].permalink + "-$index",
                      onClicked: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext c) {
                          return MovieDetailsPage(
                            contentDetails: section.data[index],
                            heroIndex: index,
                          );
                        }));
                      }));
            }),
        height: isVertical ? VR_HEIGHT : HR_HEIGHT,
      );
    }

    Widget shimmerSection = new Padding(
      padding: EdgeInsets.only(left: 10.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 10.0), child:
              Container(
                color: Colors.grey,
                width: 100.0,
                height: 20.0,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 10.0),
              child: Container(
                width: HR_WIDTH,
                height: HR_HEIGHT,
                color: Colors.grey,
              ),),
              Padding(padding: EdgeInsets.only(right: 10.0),
                child: Container(
                  width: HR_WIDTH,
                  height: HR_HEIGHT,
                  color: Colors.grey,
                ),)
            ],
          )
        ],
      ),
    );

    Widget body = apiFetched
        ? new Container(
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
                        "0") {
                      return new Container(
                        child: new FutureBuilder<ui.Image>(
                          future: _getImage(homePageData
                              .sectionName[index - 2].data[0].posterUrl),
                          builder: (BuildContext context,
                              AsyncSnapshot<ui.Image> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.width > snapshot.data.height) {
                                return new FeatureSection(
                                  section: homePageData.sectionName[index - 2],
                                  isVertical: false,
                                  buttonBgColor: Colors.transparent,
                                  buttonText: "More >",
                                  buttonTextColor: primaryColor,
                                  onButtonPress: () {
                                    Utils.snackBar(
                                        homePageData
                                            .sectionName[index - 2].sectionId,
                                        _context);
                                  },
                                  child: horizontalList(false,
                                      homePageData.sectionName[index - 2]),
                                );
                              } else {
                                return new FeatureSection(
                                  section: homePageData.sectionName[index - 2],
                                  isVertical: true,
                                  buttonBgColor: Colors.transparent,
                                  buttonText: "More>",
                                  buttonTextColor: primaryColor,
                                  onButtonPress: () {
                                    Utils.snackBar(
                                        homePageData
                                            .sectionName[index - 2].sectionId,
                                        _context);
                                  },
                                  child: horizontalList(true,
                                      homePageData.sectionName[index - 2]),
                                );
                              }
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
          ))
        : Container(
            child: Center(
            child:
                /*ColorLoaderPlain(
              colors: loaderColors,
              duration: Duration(milliseconds: 1200),
            )*/
                Shimmer.fromColors(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 900 / (1600 / screenWidth),
                          color: Colors.grey,
                        ),
                        shimmerSection,
                        shimmerSection,
                      ],
                    ),
                    baseColor: Colors.grey.withOpacity(0.5),
                    highlightColor: Colors.grey.withOpacity(0.7)),
          ));

    scaffold = new Scaffold(
        backgroundColor: Colors.black,
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
  void onApiSuccess({GetAppHomeFeatureModel data}) {
    // TODO: implement onApiSuccess
    setState(() {
      homePageData = data;
      apiFetched = true;
    });
  }
}
