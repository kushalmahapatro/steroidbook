import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/widgets/FeatureContentHorizontal.dart';
import 'package:vod/widgets/FeatureContentVertical.dart';

class FeatureSection extends StatefulWidget {

  final HomeFeaturePageSectionModel section;
  final String buttonText;
  final Color buttonBgColor, buttonTextColor, titleTextColor;
  final Function onButtonPress;
  final bool isVertical;

  FeatureSection({
    this.section,
    this.buttonText = "View More",
    this.buttonBgColor = primaryColor,
    this.titleTextColor = Colors.white,
    this.buttonTextColor = Colors.white,
    this.onButtonPress,
    this.isVertical = false,
  });

  @override
  _FeatureSectionState createState() => _FeatureSectionState();
}

class _FeatureSectionState extends State<FeatureSection> {
  String _buttonText;
  Color _buttonBgColor, _buttonTextColor, _titleTextColor;
  bool _isVertical;

  @override
  void initState() {
    _buttonBgColor ??= widget.buttonBgColor;
    _buttonTextColor ??= widget.buttonTextColor;
    _buttonText ??= widget.buttonText;
    _isVertical ??= widget.isVertical;
    _titleTextColor ??= widget.titleTextColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget horizontalList = new Container(
      child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: int.parse(widget.section.total) >= SECTION_CONTENT_LIMIT ? SECTION_CONTENT_LIMIT : int.parse(widget.section.total),
          itemBuilder: (BuildContext ctxt, int index) {

            if( widget.isVertical ) {
              return new VrFeatureContent(
                  image: NetworkImage(widget.section.homeFeaturePageSectionDetailsModel[index].poster_url.toString().trim()),
                  title: widget.section.homeFeaturePageSectionDetailsModel[index].name.toString().trim());
            }else{
              return new HrFeatureContent(
                  image: NetworkImage(widget.section.homeFeaturePageSectionDetailsModel[index].poster_url.toString().trim()),
                  title: widget.section.homeFeaturePageSectionDetailsModel[index].name.toString().trim());
            }
          }),
      height: _isVertical ? VR_HEIGHT : HR_HEIGHT,
    );
    // TODO: implement build
    return Column(children: <Widget>[
      Padding(
        padding: new EdgeInsets.fromLTRB(7, 7, 4, 7),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.section.title,
              style: new TextStyle(color: widget.titleTextColor, fontSize: SECTION_TITLE_SIZE ),
            ),
            int.parse(widget.section.total) > SECTION_CONTENT_LIMIT ?
            FlatButton(
                onPressed: widget.onButtonPress,
                color: widget.buttonBgColor,
                child: Text(
                  widget.buttonText,
                  style: TextStyle(color: widget.buttonTextColor),
                )) :
            FlatButton(
                onPressed: (){},
                color: Colors.transparent,
                child: Text(
                  "",
                  style: TextStyle(color: Colors.transparent),
                )),
          ],
        ),
      ),
      horizontalList,
    ]);
  }


}
