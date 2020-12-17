import 'package:formulafantasy/components/driver_tile.dart';
import 'package:formulafantasy/components/points.dart';
import 'package:formulafantasy/components/position.dart';
import 'package:formulafantasy/constants/styles.dart';
import 'package:formulafantasy/models/leaderboard_model.dart';
import 'package:flutter/material.dart';

class IndividualBoard extends StatelessWidget {
  final List<Leaderboard> leaders;
  final Leaderboard myPosition;
  IndividualBoard({this.leaders, this.myPosition});
  Widget _getProgressIcon(Leaderboard lead) {
    int prev = lead.prevPosition;
    int curr = lead.position;

    if (prev == -1) {
      return Icon(Icons.keyboard_arrow_up, color: Colors.green);
    }
    if (prev == curr) {
      return Icon(Icons.horizontal_rule, color: Colors.white54);
    }
    if (prev < curr) {
      return Icon(Icons.keyboard_arrow_down, color: Colors.red);
    }
    return Icon(Icons.keyboard_arrow_up, color: Colors.green);
  }

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text("G/L", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        myPosition != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Position",
                    style: headerText,
                  ),
                ),
              )
            : SizedBox.shrink(),
        myPosition != null
            ? ListTile(
                title: DriverTile(
                childWidget: Row(
                  children: <Widget>[
                    Position(myPosition.position),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(myPosition.name.split(" ")[0],
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 5.0),
                        Text(myPosition.leagueCount.toString() + " Leagues",
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.white54))
                      ],
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Points(myPosition.points)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: _getProgressIcon(myPosition))
                  ],
                ),
              ))
            : SizedBox.shrink(),
        myPosition != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Leaderboard",
                    style: headerText,
                  ),
                ),
              )
            : SizedBox.shrink(),
        Expanded(
          child: ListView.builder(
              itemCount: leaders.length,
              itemBuilder: (context, index) {
                Leaderboard lead = leaders[index];
                String s = lead.name.split(" ")[0];
                String formatted = s[0].toUpperCase() + s.substring(1);
                return ListTile(
                  title: DriverTile(
                    childWidget: Row(
                      children: <Widget>[
                        Position(index + 1),
                        SizedBox(width: 8.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formatted,
                                style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5.0),
                            Text(lead.leagueCount.toString() + " Leagues",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white54))
                          ],
                        ),
                        Expanded(child: SizedBox.shrink()),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Points(lead.points)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: _getProgressIcon(lead))
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
