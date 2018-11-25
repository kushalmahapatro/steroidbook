import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/utils/Utils.dart';

class FeatureContent extends StatefulWidget {
  final ImageProvider image;
  final String title;
  final Color titleColor;
  final Color gradientEndColor;
  final int textLine;
  final Function onClicked;
  final bool isVertical;

  FeatureContent(
      {
        this.image,
        this.title = "",
        this.titleColor = Colors.white,
        this.gradientEndColor = Colors.black,
        this.textLine = 1,
        this.onClicked,
        this.isVertical,
      });

  @override
  _FeatureContentState createState() => _FeatureContentState();
}


class _FeatureContentState extends State<FeatureContent> {
  String _title;
  Color _titleColor, _gradientEndColor;
  int _textLine;
  var _loadImage = new AssetImage(
      'assets/images/logo.png');
  bool _checkLoaded = true, _isVertial = false;
  Function _onClicked = (){};
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
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
        width: widget.isVertical ? VR_WIDTH : HR_WIDTH,
        height: widget.isVertical ? VR_HEIGHT : HR_HEIGHT,
        child: new Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: new BorderRadius.circular(RADIOUS_CARD),
                child: new Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: _checkLoaded ? _loadImage : widget.image,
                          fit: BoxFit.contain)),
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
      ),
    );
  }
}
