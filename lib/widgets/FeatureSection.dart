import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vod/sdk/api/GetAppHomeFeature.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Constants.dart';
import 'package:vod/widgets/Buttons.dart';

class FeatureSection extends StatefulWidget {
  final HomeFeaturePageSectionModel section;
  final String buttonText;
  final Color buttonBgColor, buttonTextColor, titleTextColor;
  final Function onButtonPress;
  final bool isVertical;
  final Widget child;

  FeatureSection({
    this.section,
    this.buttonText = "View More",
    this.buttonBgColor = primaryColor,
    this.titleTextColor = Colors.white,
    this.buttonTextColor = Colors.white,
    this.onButtonPress,
    this.isVertical = false,
    this.child,
  });

  @override
  _FeatureSectionState createState() => _FeatureSectionState();
}

class _FeatureSectionState extends State<FeatureSection> {
  String _buttonText;
  Color _buttonBgColor, _buttonTextColor, _titleTextColor;
  bool _isVertical;
  int clickedPosition;

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
    // TODO: implement build
    return Column(children: <Widget>[
      Padding(
        padding: new EdgeInsets.fromLTRB(7, 7, 4, 7),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.section.title,
              style: new TextStyle(
                  color: widget.titleTextColor, fontSize: SECTION_TITLE_SIZE),
            ),
            int.parse(widget.section.total) > SECTION_CONTENT_LIMIT
                ? VodButton(
                    label: widget.buttonText,
                    textColor: widget.buttonTextColor,
                    buttonColor: widget.buttonBgColor,
                    onClicked: widget.onButtonPress,
                    radious: 4.0,
                  )
                : VodButton(
                    label: "",
                    textColor: Colors.transparent,
                    buttonColor: Colors.transparent,
                    onClicked: () {},
                    radious: 4.0,
                  ),
          ],
        ),
      ),
      widget.child != null ? widget.child : Container(),
    ]);
  }
}
