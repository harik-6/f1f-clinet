import 'package:flutter/material.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/components/position.dart';

class LeaderBoardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LeaderBoardWidget();
  }
}

class _LeaderBoardWidget extends State<LeaderBoardWidget> {
  int activeTab = 0;
  bool isLeaderBoardLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: isLeaderBoardLoading
            ? PreLoader()
            : Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text("Pts",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: DriverTile(
                              childWidget: Row(
                                children: <Widget>[
                                  Position(index + 1),
                                  SizedBox(width: 5.0),
                                  SizedBox(width: 8.0),
                                  DriverNames("", "Username"),
                                  Expanded(child: SizedBox.shrink()),
                                  Points(123)
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ));
  }
}
