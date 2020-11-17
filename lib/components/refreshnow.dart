import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  Function callback;
  Refresh({this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: callback,
            ),
            Text("Refresh now", style: TextStyle(fontSize: 18.0))
          ],
        ));
  }
}
