import 'package:flutter/material.dart';

class LeagueResult extends StatelessWidget {
  final bool status;
  final Function callback;
  LeagueResult({this.status, this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: status
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 80.0),
                  SizedBox(height: 20.0),
                  Text("Joined the league.", style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 10.0),
                  Text("Results will be updated after the race.",
                      style: TextStyle(fontSize: 14.0)),
                  SizedBox(height: 20.0),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_outlined,
                      color: Colors.white24, size: 60.0),
                  SizedBox(height: 20.0),
                  Text("Sorry!! Something went wrong",
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    width: 120.0,
                    child: RaisedButton(
                      onPressed: () {
                        callback();
                      },
                      color: Colors.green[600],
                      child: Text(
                        "Try again",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ));
  }
}
