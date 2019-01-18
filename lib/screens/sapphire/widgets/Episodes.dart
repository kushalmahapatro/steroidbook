import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/widgets/FeatureContent.dart';

class VodEpisodes extends StatefulWidget {
  final String seasonName, episodeName, duration;
  final Function onEpisodeClick, onDownloadClick;
  final bool showDownload, isVertical;

  final ImageProvider image;

  VodEpisodes(
      {this.seasonName,
      this.episodeName,
      this.duration,
      this.onDownloadClick,
      this.onEpisodeClick,
      this.showDownload,
      this.isVertical,
      this.image});

  @override
  _VodEpisodesState createState() => _VodEpisodesState();
}

class _VodEpisodesState extends State<VodEpisodes> {
  bool _showDownload;

  @override
  void initState() {
    _showDownload ??= widget.showDownload;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: ClipRRect(
          borderRadius: new BorderRadius.circular(RADIOUS_CARD),
          child: Container(
            color: Colors.white12,
            child: Row(
              children: <Widget>[section1(), section2(), Spacer(), section3()],
            ),
          )),
    );
  }

  Widget logoWidget() {
    return Center(
        child: Container(
            child: InkWell(
      child: Icon(Icons.play_circle_outline, color: primaryColor, size: 30.0),
    )));
  }

  Widget section1() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new FeatureContent(
          isEpisode: true,
          cardRadius: 0.0,
          image: widget.image,
          isVertical: widget.isVertical,
          gradientEndColor: Colors.transparent,
          heroTag: widget.seasonName + "-$widget.episodeName",
        ),
        logoWidget(),
      ],
    );
  }

  Widget section2() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.seasonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  widget.episodeName,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 12.0),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  widget.duration,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 12.0),
                )),
          ],
        ));
  }

  Widget section3() {
    return Center(
      child: Icon(
        Icons.file_download,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
