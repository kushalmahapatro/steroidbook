import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Utils.dart';

class VodButton extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final String label;
  final String imageAsset;
  final Function onClicked;

  VodButton({
    this.buttonColor = primaryColor,
    this.textColor = Colors.white,
    this.label = "Button",
    this.imageAsset,
    this.onClicked,
  });

  @override
  _VodButtonState createState() => _VodButtonState();
}

class _VodButtonState extends State<VodButton> {
  Color _buttonColor, _textColor;

  @override
  void initState() {
    _buttonColor ??= widget.buttonColor;
    _textColor ??= widget.textColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        child: FlatButton(
            color: widget.buttonColor,
            child: widget.label == null ? image()
                : widget.imageAsset == null ? text() : imageAndText(),
            onPressed: widget.onClicked));
  }

  Widget image(){
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
        child: Image.asset(
          widget.imageAsset,
          fit: BoxFit.fitHeight,
        ));
  }

  Widget text(){
    return Text(
      widget.label,
      style: TextStyle(color: widget.textColor),
    );
  }
  Widget imageAndText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        image(),
        text(),
      ],
    );
  }
}
