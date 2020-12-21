import 'package:flutter/material.dart';
import 'package:formulafantasy/components/driver_names.dart';
import 'package:formulafantasy/components/driver_tile.dart';
import 'package:formulafantasy/components/points.dart';
import 'package:formulafantasy/components/position.dart';
import 'package:formulafantasy/components/team_icon.dart';
import 'package:formulafantasy/components/team_indicator.dart';
import 'package:formulafantasy/models/driver_model.dart';

class DriverStandings extends StatefulWidget {
  final List<Driver> drivers;
  static const double base_gap = 10.0;
  const DriverStandings({Key key, this.drivers}) : super(key: key);
  @override
  _DriverStandings createState() => _DriverStandings();
}

class _DriverStandings extends State<DriverStandings> {
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
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text("Team", style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text("Pts", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.drivers.length,
                  itemBuilder: (context, index) {
                    Driver driver = widget.drivers[index];
                    return GestureDetector(
                      onTap: null,
                      child: ListTile(
                        title: DriverTile(
                            childWidget: Row(
                          children: <Widget>[
                            Position(index + 1),
                            SizedBox(width: 5.0),
                            TeamIndicator(driver.team),
                            SizedBox(width: 8.0),
                            DriverNames(driver.firstName, driver.secondName),
                            Expanded(child: SizedBox.shrink()),
                            TeamIcon(driver.team, 16.0),
                            Points(driver.points)
                          ],
                        )),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
