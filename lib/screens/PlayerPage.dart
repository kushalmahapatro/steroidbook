import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vod/screens/MovieDetailsPage.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/widgets/video_player.dart';

class Player extends StatefulWidget {
  final HomeFeaturePageSectionDetailsModel contentDetails;

  Player({Key key, @required this.contentDetails}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  static const int kStartValue = 4;
  VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showController = false;
  bool _isControllerVisible = false;
  Timer _timer;
  String videoUrl =
      "https://d1gafjrnux9y1n.cloudfront.net/4050/EncodedVideo/uploads/movie_stream/full_movie/93913/stream.mpd";
  String licenseUrl =
      "https://wv.service.expressplay.com/hms/wv/rights/?ExpressPlayToken=BAAAABSMKeEAAABglVNLf9ZDd2Hjs7ws67vU0rB6QSbaoi8T-TlTsDOs_SLQlFMrJP72zMmRvf_h8O8hS110xezAuTVJISQB4MqasPXno7RbaEEFc5NmvcwFzV3_j_RHuvDw4gifKOuL1ZTl7kLOX3SZptM0KybQ4TEExRVC_Fw";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl, licenseUrl)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (_controller.value.initialized) {
          _controller.play();
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
//    Screen.keepOn(true);
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    Future<bool> _onBackPressed() {
      return Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (c) =>
              new MovieDetailsPage(contentDetails: widget.contentDetails)));
    }

    bool _controllerWasPlaying = false;
    Widget progressBar(double val) {
      return Slider(
        value: val,
        min: 0.0,
        max: 1.0,
        activeColor: primaryColor,
        inactiveColor: Colors.white,
        onChanged: (double value) {
          setState(() {
            print(value);
            val = value;
            if (!_controller.value.initialized) {
              return;
            }
            final Duration position = _controller.value.duration * value;
            _controller.seekTo(position);
          });
        },
        onChangeStart: (double value) {
          setState(() {
            _showController = true;
            _isControllerVisible = true;
            _timer.cancel();
          });

          if (!_controller.value.initialized) {
            return;
          }
          _controllerWasPlaying = _controller.value.isPlaying;
          if (_controllerWasPlaying) {
            _controller.pause();
          }
        },
        onChangeEnd: (double value) {
          if (_controllerWasPlaying) {
            _controller.play();
            _timer = new Timer(const Duration(milliseconds: 5000), () {
              setState(() {
                _showController = false;
                _isControllerVisible = false;
              });
            });
          }
        },
      );
    }

    Widget videoPlayerControls() {
      final int duration = _controller.value.duration.inMilliseconds;
      final int position = _controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (DurationRange range in _controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      double val = position / duration;
      _isControllerVisible = true;
      _timer = new Timer(const Duration(milliseconds: 5000), () {
        setState(() {
          _showController = false;
          _isControllerVisible = false;
        });
      });
      return Container(
        color: Colors.black.withOpacity(0.3),
        child: new Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Align(
                        child: InkWell(
                            onTap: _onBackPressed,
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ))),
                        alignment: Alignment.topLeft),
                    Align(
                        child: InkWell(
                            onTap: () {},
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ))),
                        alignment: Alignment.topRight),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Wrap(
                            spacing: 30.0,
                            children: <Widget>[
                              Container(
                                child: Center(
                                    child: Icon(
                                      Icons.fast_rewind,
                                      color: Colors.white,
                                      size: 40.0,
                                    )),
                                height: 70.0,
                              ),
                              InkWell(
                                  onTap: () {
                                    print("play tap");
                                    setState(() {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                    });
                                  },
                                  child: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause_circle_outline
                                        : Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 70.0,
                                  )),
                              Container(
                                child: Center(
                                    child: Icon(
                                      Icons.fast_forward,
                                      color: Colors.white,
                                      size: 40.0,
                                    )),
                                height: 70.0,
                              )
                            ],
                          )
                        ],
                      )),
                ),
                Align(
                  child:
                  /* VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                padding: EdgeInsets.only(bottom: 50.0),
                colors: VideoProgressColors(
                    playedColor: primaryColor,
                    backgroundColor: Colors.white.withOpacity(0.4),
                    bufferedColor: Colors.white.withOpacity(0.7)),
              )*/
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            getTime(_controller.value.position),
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(child: progressBar(val)),
                          Text(
                            getTime(_controller.value.duration),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  alignment: Alignment.bottomCenter,
                )
              ],
            )),
      );
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Video Demo',
          home: Scaffold(
              body: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(color: appbackgroundColor),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _controller.value.initialized
                        ? GestureDetector(
                        child: Center(
                          child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller)),
                        ),
                        onTap: () {
                          setState(() {
                            print(_controller.value.aspectRatio);
                            print(screenWidth / screenHeight);
                            if (_isControllerVisible) {
                              _timer.cancel();
                              _showController = false;
                              _isControllerVisible = false;
                            } else {
                              _showController = true;
                            }
                          });
                        },
                    )
                        : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Loading...",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ))
                          ],
                        )),
                    _controller.value.isBuffering
                        ? CircularProgressIndicator()
                        : new Container(),
                    _showController ? videoPlayerControls() : Container(),
                  ],
                ),
              )),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String getTime(Duration position) {
    int milli = position.inMilliseconds; //38135000
    int hr = (milli / 36000000).round(); // 38135000 / 36000000 = 1
    int min = ((milli % 36000000) / 60000)
        .round(); // (38135000 % 36000000) / 6000 = 35
    int sec = (((milli % 36000000) % 60000) / 1000).round();
    return "" +
        (hr > 0 && hr <= 9
            ? "0" + hr.toString() + ":"
            : hr == 0 ? "" : hr.toString() + ":") +
        (min > 0 && min <= 9
            ? "0" + min.toString() + ":"
            : min == 0 ? "00:" : min.toString() + ":") +
        (sec > 0 && sec <= 9
            ? "0" + sec.toString()
            : sec == 0 ? "00" : sec.toString());
  }
}
