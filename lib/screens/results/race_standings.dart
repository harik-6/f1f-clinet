import 'package:flutter/material.dart';
import 'package:formulafantasy/components/driver_names.dart';
import 'package:formulafantasy/components/driver_tile.dart';
import 'package:formulafantasy/components/points.dart';
import 'package:formulafantasy/components/position.dart';
import 'package:formulafantasy/components/team_indicator.dart';
import 'package:formulafantasy/constants/styles.dart';
import 'package:formulafantasy/models/driver_model.dart';
import 'package:formulafantasy/models/race_result_model.dart';

class RaceStandings extends StatefulWidget {
  final List<RaceResult> results;
  const RaceStandings({Key key, this.results}) : super(key: key);
  @override
  _RaceStandings createState() => _RaceStandings();
}

class _RaceStandings extends State<RaceStandings>
    with AutomaticKeepAliveClientMixin<RaceStandings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
                    child: Text("Time", style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text("Pts", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            (widget.results == null || widget.results.length == 0)
                ? Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flag, color: Colors.white, size: 36.0),
                      SizedBox(height: 10.0),
                      Text("Race result will be updated soon.",
                          style: headerText)
                    ],
                  ))
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.results.length,
                        itemExtent: 80.0,
                        itemBuilder: (context, index) {
                          RaceResult result = widget.results[index];
                          Driver driver = result.driver;
                          return Opacity(
                            opacity: result.time == "DNF" ? 0.5 : 1.0,
                            child: GestureDetector(
                              onTap: null,
                              child: ListTile(
                                title: DriverTile(
                                  childWidget: Row(
                                    children: <Widget>[
                                      Position(index + 1),
                                      SizedBox(width: 5.0),
                                      TeamIndicator(result.team),
                                      SizedBox(width: 8.0),
                                      DriverNames(
                                          driver.firstName, driver.secondName),
                                      Expanded(child: SizedBox.shrink()),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text(result.time,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      Points(result.points)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
