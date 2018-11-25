import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vod/controllers/HomePageControllers.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
import 'package:vod/utils/CircularLoader.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/MyBehaviour.dart';
import 'package:vod/utils/Utils.dart';
import 'package:vod/widgets/Carousel.dart';
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
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "Sapphire",
    style: new TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget buildBar(BuildContext context) {
      return new AppBar(
          centerTitle: true,
          title: appBarTitle,
          backgroundColor: primaryColor,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                Utils.snackBar("Searcg", _context);
              },
            ),
          ]);
    }

    List bannerImages() {
      List image = new List();
      for (int i = 0; i < homePageData.homePageBannerModelList.length; i++) {
        image.add(NetworkImage(homePageData
            .homePageBannerModelList[i].image_path
            .toString()
            .trim()));
      }
      return image;
    }

    Widget body = apiFetched
        ? new Container(
            child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
                itemCount: homePageData.homePageSectionModelList.length + 2,
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
                      height: 3,
                      color: primaryColor,
                    );
                  } else {
                    if (homePageData
                            .homePageSectionModelList[index - 2].section_type ==
                        "0") {
                      return new FeatureSection(
                        section:
                            homePageData.homePageSectionModelList[index - 2],
                        onButtonPress: () {
                          Utils.snackBar(
                              homePageData.homePageSectionModelList[index - 2]
                                  .section_id,
                              _context);
                        },
                      );
                    } else {
                      return new Container();
                    }
                  }
                }),
          ))
        : Container(
            child: Center(
              child: ColorLoader(
                color1: primaryColor,
                color2: Colors.white,
                color3: primaryColor,
              ),
            ),
          );
    ;

    scaffold = new Scaffold(
        appBar: buildBar(context),
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
