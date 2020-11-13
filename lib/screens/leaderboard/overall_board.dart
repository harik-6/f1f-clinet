import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/components/position.dart';


class OverallBoard extends StatefulWidget{
  @override
 _OverallBoard createState() {
    return _OverallBoard();
  }
}

class _OverallBoard extends State<OverallBoard> with AutomaticKeepAliveClientMixin<OverallBoard> {
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text("Pts", style: TextStyle(color: Colors.white)),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
