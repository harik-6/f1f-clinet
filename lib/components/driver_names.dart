import 'package:flutter/material.dart';

class DriverNames extends StatelessWidget {
  final String fname;
  final String sname;
  DriverNames(this.fname, this.sname);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          this.fname.length > 0
              ? Text(this.fname,
                  style: TextStyle(
                    color: Colors.white54,
                  ))
              : SizedBox.shrink(),
          Text(this.sname,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
