import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  double size;

  CircleWidget(this.size, this.hour);
  int hour;
  @override
  Widget build(BuildContext context) {
    final checkColor = hour>= 20 ||hour<= 6;
    return new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              checkColor ? Color(0xffBCB9AF) : Color(0xffFFBB7C),
              checkColor ? Color(0xffFAF8F4) : Color(0xffFF61A1),
            ],
          ),
          shape: BoxShape.circle,
        ));
  }
}
