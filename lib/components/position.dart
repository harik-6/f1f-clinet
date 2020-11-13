import 'package:flutter/material.dart';

class Position extends StatelessWidget {
  final int pos;
  Position(this.pos);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right:4.0,left: pos<10?14.0:4.0),
      child: Text(pos.toString(),style: TextStyle(fontSize: 18.0, color: Colors.white)),
    );
  }
}
