import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  SideButton({Key key, this.icon, this.text, this.onPressed, this.isPressed})
      : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isPressed;

  final upColor = Colors.blueGrey[200];
  final downColor = Colors.blueGrey[400];
  final borderColor = Colors.blueGrey[400];
  final contentColor = Colors.black;

  Widget _getButtonContent() {
    if (icon != null) {
      return Icon(icon, color: contentColor);
    } else if (text != null) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: contentColor,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: isPressed ? downColor : upColor,
          ),
          alignment: Alignment.center,
          width: 75.0,
          height: 75.0,
          child: _getButtonContent(),
        ),
        onTap: () => {if (onPressed != null) onPressed()});
  }
}
