import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 48.0, color: Colors.white54),
          SizedBox(height: 10.0),
          Text("Device is not connected to internet",
              style: TextStyle(fontSize: 16.0)),
        ],
      ),
    ));
  }
}
