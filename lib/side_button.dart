import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideButton extends StatefulWidget {
  SideButton({Key key, this.icon, this.text, this.onPressed}) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  _SideButtonState createState() => _SideButtonState();
}

class _SideButtonState extends State<SideButton> {
  bool _isPressed = false;
  final upColor = Colors.blueGrey[200];
  final downColor = Colors.blueGrey[400];
  final borderColor = Colors.blueGrey[400];
  final contentColor = Colors.black;

  Widget _getButtonContent() {
    if (widget.icon != null) {
      return Icon(widget.icon, color: contentColor);
    } else if (widget.text != null) {
      return Text(
        widget.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: contentColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: _isPressed ? downColor : upColor,
        ),
        alignment: Alignment.center,
        width: 75.0,
        height: 75.0,
        child: _getButtonContent(),
      ),
      onTap: () => {
        setState(() {
          _isPressed = !_isPressed;
          if (widget.onPressed != null) widget.onPressed();
        })
      },
    );
  }
}
