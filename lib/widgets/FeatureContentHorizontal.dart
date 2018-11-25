import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/Constants.dart';

class HrFeatureContent extends StatefulWidget {
  final ImageProvider image;
  final String title;
  final Color titleColor;
  final Color gradientEndColor;
  final int textLine;

  HrFeatureContent(
      {
        this.image,
        this.title = "",
        this.titleColor = Colors.white,
        this.gradientEndColor = Colors.black,
        this.textLine = 1,
      });

  @override
  _HrFeatureContentState createState() => _HrFeatureContentState();
}


class _HrFeatureContentState extends State<HrFeatureContent> {
  String _title;
  Color _titleColor, _gradientEndColor;
  int _textLine;
  var _loadImage = new AssetImage(
      'assets/images/logo.png');
  bool _checkLoaded = true;

  @override
  void initState() {
    _title ??= widget.title;
    _titleColor ??= widget.titleColor;
    _gradientEndColor ??= widget.gradientEndColor;
    _textLine ??= widget.textLine;

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
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
      width: HR_WIDTH,
      height: HR_HEIGHT,
      child: new Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.circular(4.0),
            child: new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(image: _checkLoaded ? _loadImage : widget.image,
                      fit: BoxFit.contain)
              ),
            )
          ),
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
                        child: Text(widget.title,
                          maxLines: widget.textLine,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(color: widget.titleColor, fontSize: SECTION_CONTENT_NAME),
                        ),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
