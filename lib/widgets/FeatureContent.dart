import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/Constants.dart';

class FeatureContent extends StatefulWidget {
  final ImageProvider image;
  final String title, heroTag;
  final Color titleColor;
  final Color gradientEndColor;
  final int textLine;
  final double cardRadius;
  final Function onClicked;
  final bool isVertical, isEpisode;

  FeatureContent(
      {this.image,
      this.title = "",
      this.titleColor = Colors.white,
      this.gradientEndColor = Colors.black,
      this.textLine = 1,
      this.onClicked,
      this.isVertical,
      this.isEpisode = false,
      this.cardRadius = RADIOUS_CARD,
      this.heroTag});

  @override
  _FeatureContentState createState() => _FeatureContentState();
}

class _FeatureContentState extends State<FeatureContent> {
  String _title;
  Color _titleColor, _gradientEndColor = Colors.transparent;
  int _textLine;
  var _loadImage = new AssetImage('assets/images/logo.png');
  bool _checkLoaded = true, _isVertial = false;
  Function _onClicked = () {};

  @override
  void initState() {
    _title ??= widget.title;
    _titleColor ??= widget.titleColor;
    _gradientEndColor ??= widget.gradientEndColor;
    _textLine ??= widget.textLine;
    _onClicked ??= widget.onClicked;
    _isVertial ??= widget.isVertical;

    widget.image.resolve(new ImageConfiguration()).addListener((_, __) {
      if (mounted) {
        setState(() {
          _checkLoaded = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: widget.onClicked,
      child: Hero(
          tag: widget.heroTag,
          child: Container(
            width: widget.isVertical
                ? VR_WIDTH
                : widget.isEpisode ? HR_WIDTH_EPISODE : HR_WIDTH,
            height: widget.isVertical
                ? VR_HEIGHT
                : widget.isEpisode ? HR_HEIGHT_EPISODE : HR_HEIGHT,
            child: new Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: new BorderRadius.circular(widget.cardRadius),
                    child: new Container(
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: _checkLoaded ? _loadImage : widget.image,
                              fit: _checkLoaded
                                  ? BoxFit.contain
                                  : BoxFit.cover)),
                    )),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      // 10% of the width, so there are ten blinds.
                      colors: [Colors.transparent, widget.gradientEndColor],
                      // transparent to black
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    new Expanded(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                widget.title,
                                maxLines: widget.textLine,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    color: widget.titleColor,
                                    fontSize: SECTION_CONTENT_NAME),
                              ),
                            )))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
