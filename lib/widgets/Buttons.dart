import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';

class VodButton extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final String label;
  final String imageAsset;
  final Function onClicked;
  final double height, radious, width;
  final bool isCiruclar;

  VodButton({
    this.buttonColor = primaryColor,
    this.textColor = Colors.white,
    this.label,
    this.imageAsset,
    @required this.onClicked,
    this.height,
    this.width,
    this.radious,
    this.isCiruclar = false,
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
    Widget button;
    widget.isCiruclar
        ? button = Container(
            width: widget.width,
            height: widget.height,
            child: FlatButton(
                color: widget.buttonColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(
                        widget.radious != null ? widget.radious : 00.0)),
                child: widget.label == null
                    ? image()
                    : widget.imageAsset == null ? text() : imageAndText(),
                onPressed: widget.onClicked))
        : button = FlatButton(
            color: widget.buttonColor,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(
                    widget.radious != null ? widget.radious : 00.0)),
            child: widget.label == null
                ? image()
                : widget.imageAsset == null ? text() : imageAndText(),
            onPressed: widget.onClicked);
    return button;
  }

  Widget image() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
        child: Image.asset(
          widget.imageAsset,
          fit: BoxFit.fitHeight,
          height: widget.height,
          width: widget.width,
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
