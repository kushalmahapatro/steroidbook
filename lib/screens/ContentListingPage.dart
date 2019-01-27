import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vod/bloc/bloc_content_list.dart';
import 'package:vod/controllers/ContentListingControllers.dart';
import 'package:vod/screens/sapphire/MovieDetailsPage.dart';
import 'package:vod/screens/Shimmer/ContentListingShimmer.dart';
import 'package:vod/sdk/api/GetContentList.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/utils/Utils.dart';
import 'package:vod/widgets/FeatureContent.dart';

class ContentListingPage extends StatefulWidget {
  final String appBarTitle, permalink;

  ContentListingPage(
      {Key key, @required this.appBarTitle, @required this.permalink})
      : super(key: key);

  _ContentListingPageState createState() => _ContentListingPageState();
}

class _ContentListingPageState extends State<ContentListingPage>
    implements ContentListingListener {
  Scaffold scaffold;
  BuildContext _context;
  List<MovieList> _modelData;
  bool apiFetched = false;
  bool vertical = false;
  double gridCount = 2;
  final scaffoldState = GlobalKey<ScaffoldState>();
  ContentListModel apiModel;
  ContentListingController controller;
  int _offset, _total;
  bool loading;
  ScrollController scrollController;
  bool _loadingMore;
  bool _hasMoreItems;
  int _limit;
  Future _initialLoad;

  @override
  void initState() {
    // TODO: implement initState
    _modelData = new List<MovieList>();
    _offset = 1;
    _total = 0;
    _limit = 10;
    _hasMoreItems = false;
    _loadingMore = false;
    controller = ContentListingController(listener: this);
    _initialLoad = controller.callApi(widget.permalink, _offset, _limit, true);
    scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  Future _loadMoreItems() async {
    _offset = _offset + 1;
    controller.callApi(widget.permalink, _offset, _limit, false);
    _loadingMore = true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    double screenWidth = MediaQuery.of(context).size.width;

    Widget body = FutureBuilder(
        future: _initialLoad,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ContentListingShimmer();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: vertical
                      ? (screenWidth ~/ VR_WIDTH_CONTENT).toInt()
                      : (screenWidth ~/ HR_WIDTH).toInt(),
                  childAspectRatio: vertical
                      ? (VR_WIDTH_CONTENT / VR_HEIGHT_CONTENT)
                      : (HR_WIDTH / HR_HEIGHT),
                ),
                itemCount: _modelData.length,
                itemBuilder: (context, index) {
                  // check if the last item in the list view has scrolled into view and if there are more items
                  if (_hasMoreItems && index == _modelData.length - 1) {
                    if (!_loadingMore) {
                      _loadMoreItems();
                    }

                    return new Padding(
                        padding:
                            EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                        child: Shimmer.fromColors(
                            child: Container(
                              color: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(5.0),
                                child: new Container(
                                  color: Colors.grey,
                                    child: Image.network(
                                        " https://upload.wikimedia.org/wikipedia/commons/1/1e/A_blank_black_picture.jpg"),),
                              ),
                            ),
                            baseColor: Colors.grey.withOpacity(0.3),
                            highlightColor: Colors.grey.withOpacity(0.5)));
                  }
                  return Container(
                    child: FeatureContent(
                        gradientEndColor: Colors.transparent,
                        image: NetworkImage(
                            _modelData[index].posterUrl.toString().trim()),
                        isVertical: vertical,
                        onClicked: () {
                          Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext c) {
                      return MovieDetailsPage(
                        contentDetails: null,
                        movieDetails: _modelData[index],
                      );
                    }));
                        }),
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                  );
                });
          }
        });

    List<Icon> icons = new List<Icon>();
    icons.add(Utils.searchIcon);
    icons.add(Utils.filterIcon);

    List<Function> click = new List<Function>();
    click.add(() {
      Utils.snackBar("Search", _context);
    });
    click.add(() {
      Utils.snackBar("Filter", _context);
    });
    scaffold = new Scaffold(
        key: scaffoldState,
        appBar: Utils.buildBar(context, widget.appBarTitle, icons, click),
        backgroundColor: Colors.black,
        body: Builder(builder: (BuildContext _buildContext) {
          _context = _buildContext;
          return body;
        }));
    return scaffold;
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 500) {
      if (_modelData.length < _total && _modelData.length != _total) {
        if (!loading) {
          _offset = _offset + 1;
          print("offset :" + _offset.toString());
          print("size :" + _modelData.length.toString());
          blocContentList.callApi(widget.permalink, _offset, 10);
          loading = true;
        }
      }
    }
  }

  @override
  void onApiFailure({Failures failure}) {
    // TODO: implement onApiFailure
  }

  @override
  void onApiSuccess(
      {ContentListModel contentListData, bool isVertical, bool firstTime}) {
    setState(() {
      if (firstTime) {
        apiModel = contentListData;
        _total = int.parse(contentListData.itemCount);
        print("total :" + _total.toString());
        vertical = isVertical;
        apiFetched = true;
      } else {
        _loadingMore = false;
      }
      _modelData.addAll(contentListData.movieList);
      _hasMoreItems = _modelData.length < _total;
    });
  }
}
