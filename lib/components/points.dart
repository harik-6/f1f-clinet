import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  final int points;
  Points(this.points);
  double horizontalPadding(int points) {
    double base = 10.0;
    if(points < 10) {
      return base+16.0;
    }
    if(points < 100) {
      return base+8.0;
    }
    return base;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right:10.0,left: horizontalPadding(points)),
      child: Text(
        points.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
