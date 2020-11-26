import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/components/position.dart';
import 'package:f1fantasy/components/team_icon.dart';
import 'package:f1fantasy/models/constructor_model.dart';

class ConstructorStandings extends StatefulWidget {
  final List<Constructor> constructors;
  const ConstructorStandings({Key key, this.constructors}) : super(key: key);
  @override
  _ConstructorStandings createState() => _ConstructorStandings();
}

class _ConstructorStandings extends State<ConstructorStandings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text("Pts", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.constructors.length,
                  itemBuilder: (context, index) {
                    Constructor constructor = widget.constructors[index];
                    return ListTile(
                      title: DriverTile(
                        childWidget: Row(
                          children: <Widget>[
                            Position(index + 1),
                            TeamIcon(constructor.shortName, 4.0),
                            SizedBox(width: 5.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(constructor.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  )),
                            ),
                            Expanded(child: SizedBox.shrink()),
                            Points(constructor.points)
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
