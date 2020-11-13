import 'package:flutter/material.dart';

class DriverTile extends StatelessWidget {
  final Widget childWidget;
  DriverTile({this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8.0),
      width: double.infinity,
      height: 72.0,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0), child: childWidget),
    );
  }
}
