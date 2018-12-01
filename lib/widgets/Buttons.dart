import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';

class VodButton extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final String label;
  final String imageAsset;
  final Function onClicked;
  final double height, radious;

  VodButton({
    this.buttonColor = primaryColor,
    this.textColor = Colors.white,
    this.label = "Button",
    this.imageAsset,
    this.onClicked,
    this.height,
    this.radious,
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
        height: widget.height != null ? widget.height : 35.0,
        child: RaisedButton(
            color: widget.buttonColor,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(widget.radious != null ? widget.radious : 00.0)),
            child: widget.label == null
                ? image()
                : widget.imageAsset == null ? text() : imageAndText(),
            onPressed: widget.onClicked),
        );
  }

  Widget image() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
        child: Image.asset(
          widget.imageAsset,
          fit: BoxFit.fitHeight,
        ));
  }

  Widget text() {
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
