import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Utils.dart';
import 'package:flutter/cupertino.dart';

class VodTextField extends StatefulWidget {
  final TextEditingController editingController;
  final Color activeColor;
  final Color inActiveColor;
  final VoidCallback focusListener;
  final TextInputType inputType;
  final String label;
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;
  final Icon obscureIcon;
  final bool obscureToggle;
  final bool enable;
  final String error;

  VodTextField({
    this.editingController,
    this.activeColor = primaryColor,
    this.inActiveColor = Colors.white12,
    this.focusListener,
    this.inputType = TextInputType.text,
    this.label = "Title",
    this.hintText = "Type value here.",
    this.obscureText = false,
    this.suffixIcon,
    this.obscureIcon,
    this.obscureToggle,
    this.enable = true,
    this.error ,
  });

  @override
  _VodTextFieldState createState() => _VodTextFieldState();
}

class _VodTextFieldState extends State<VodTextField> {
  final FocusNode  _focusNode = FocusNode();
  TextEditingController _editingController;
  Widget _suffixIcon;
  Color _labelColor;
  bool _obscureText;

  @override
  void initState() {
    _editingController ??= widget.editingController ?? TextEditingController();
    _labelColor ??= widget.inActiveColor;
    _suffixIcon = widget.suffixIcon;
    if (widget.obscureText == null)
      _obscureText = false;
    else
      _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus)
        setState(() => _labelColor = widget.activeColor);
      else
        setState(() => _labelColor = widget.inActiveColor);
    });
    iconPressed() {
      if (_suffixIcon != null) {
        if (_obscureText) {
          this.setState(() {
            _obscureText = false;
            _suffixIcon = widget.obscureIcon;
          });
        } else {
          this.setState(() {
            _obscureText = true;
            _suffixIcon = widget.suffixIcon;
          });
        }
      }
    }

    if (widget.focusListener != null)
      _focusNode.addListener(widget.focusListener);

    return TextField(
        style: new TextStyle(color: Colors.white),
        controller: _editingController,
        focusNode: _focusNode,
        enabled: widget.enable,
        keyboardType: widget.inputType,
        autofocus: false,
        obscureText: _obscureText,
        decoration: _suffixIcon != null
            ? textFieldWithIcon(iconPressed)
            : textFieldWithoutIcon());
  }

  InputDecoration textFieldWithIcon(Function iconPressed) {
    return InputDecoration(
        hintText: widget.hintText,
        errorText: widget.error,
        hintStyle: TextStyle(color: widget.inActiveColor),
        labelText: widget.label,
        labelStyle: TextStyle(color: _labelColor),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.inActiveColor)) ,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.inActiveColor)) ,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.activeColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.inActiveColor)),
        suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            child: IconButton(
              icon: _suffixIcon,
              onPressed: widget.obscureToggle == null ? null : iconPressed,
            )));
  }

  InputDecoration textFieldWithoutIcon() {
    return InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.inActiveColor),
        labelText: widget.label,
        errorText: widget.error,
        labelStyle: TextStyle(color: _labelColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.inActiveColor)) ,
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.inActiveColor)) ,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.activeColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.inActiveColor)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
