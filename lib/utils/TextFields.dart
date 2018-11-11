import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vod/utils/ColorSwatch.dart';
import 'package:vod/utils/Utils.dart';

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
  });
  @override
  _VodTextFieldState createState() => _VodTextFieldState();
}

class _VodTextFieldState extends State<VodTextField> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _editingController;
  Widget _suffixIcon;
  Color _labelColor;
  bool _obscureText ;

  @override
  void initState() {
    _editingController ??= widget.editingController ?? TextEditingController();
    _labelColor ??= widget.inActiveColor;
    if(widget.suffixIcon==null) _suffixIcon = Icon(Icons.atm,color: Colors.transparent,);
    else _suffixIcon = widget.suffixIcon;
    if (widget.obscureText == null) _obscureText = false;
    else _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener((){
      if(_focusNode.hasFocus)
        setState(()=> _labelColor = widget.activeColor);
      else
        setState(()=> _labelColor = widget.inActiveColor);
    });
    iconPressed(){
      if(_suffixIcon != null ) {
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


    if(widget.focusListener!=null) _focusNode.addListener(widget.focusListener);

    return TextField(
      controller: _editingController,
      focusNode: _focusNode,
      keyboardType: widget.inputType,
      autofocus: false,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.inActiveColor),
        labelText: widget.label,
        labelStyle: TextStyle(color: _labelColor),
        suffixIcon: new Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: IconButton(icon: _suffixIcon, onPressed: widget.obscureToggle == null ? null : iconPressed,))
      ),
    );
  }
}