import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vod/utils/ColorSwatch.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int visibleTextLength;

  DescriptionTextWidget(
      {@required this.text, this.textStyle, this.visibleTextLength});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool clicked = true;

  @override
  void initState() {
    super.initState();
    int length =
        widget.visibleTextLength != null && widget.visibleTextLength > 0
            ? widget.visibleTextLength
            : 120;

    if (widget.text.length > length) {
      firstHalf = widget.text.substring(0, length);
      secondHalf = widget.text.substring(length, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(
                  clicked ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: widget.textStyle,
                ),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        clicked ? "more" : "less",
                        style: TextStyle(color: primaryColor, fontSize: 13.0),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      clicked = !clicked;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
