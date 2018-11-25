import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _title ??= widget.title;
    _titleColor ??= widget.titleColor;
    _gradientEndColor ??= widget.gradientEndColor;
    _textLine ??= widget.textLine;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(3.0, 0, 3.0, 0),
      width: 160.0,
      height: 90.0,
      child: new Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.circular(4.0),
            child: new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(image: widget.image,
                      fit: BoxFit.cover)
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
                          style: new TextStyle(color: widget.titleColor),
                        ),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
