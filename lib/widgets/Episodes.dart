import 'package:flutter/material.dart';
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
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Row(
            children: <Widget>[section1(), section2(), Spacer(), section3()],
          ),
          Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Text(
                "This is a small description for the respective episode and will be shown below the particular episode",
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
        ]));
  }

  Widget logoWidget() {
    return Center(
        child: Container(
            child: InkWell(
      child: Icon(Icons.play_circle_outline, color: Colors.white, size: 30.0),
    )));
  }

  Widget section1() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new FeatureContent(
          isEpisode: true,
          image: widget.image,
          isVertical: widget.isVertical,
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
