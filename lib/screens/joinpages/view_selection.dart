import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/components/team_icon.dart';
import 'package:f1fantasy/components/team_indicator.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/models/user_league_details.dart';
import 'package:flutter/material.dart';

class ViewMySelection extends StatelessWidget {
  final LeagueDetails detail;
  ViewMySelection({this.detail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Selection"),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Edit"),
                    Icon(Icons.edit, color: Colors.white, size: 14.0)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text("Pole position", style: headerText),
              ),
              ListTile(
                title: DriverTile(
                  childWidget: Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      TeamIndicator(detail.fastest.team),
                      SizedBox(width: 8.0),
                      DriverNames(
                          detail.fastest.firstName, detail.fastest.secondName),
                      Expanded(child: SizedBox.shrink()),
                      TeamIcon(detail.fastest.team, 8.0)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text("Fastest lap", style: headerText),
              ),
              ListTile(
                title: DriverTile(
                  childWidget: Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      TeamIndicator(detail.pole.team),
                      SizedBox(width: 8.0),
                      DriverNames(
                          detail.pole.firstName, detail.pole.secondName),
                      Expanded(child: SizedBox.shrink()),
                      TeamIcon(detail.pole.team, 8.0)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                    "Driver for " +
                        detail.userDriverPosition.toString() +
                        "th position",
                    style: headerText),
              ),
              ListTile(
                title: DriverTile(
                  childWidget: Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      TeamIndicator(detail.userDriver.team),
                      SizedBox(width: 8.0),
                      DriverNames(detail.userDriver.firstName,
                          detail.userDriver.secondName),
                      Expanded(child: SizedBox.shrink()),
                      TeamIcon(detail.userDriver.team, 8.0)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text("Driver selected", style: headerText),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: detail.drivers.length,
                  itemBuilder: (context, index) {
                    Driver driver = detail.drivers[index];
                    return ListTile(
                      title: DriverTile(
                        childWidget: Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            TeamIndicator(driver.team),
                            SizedBox(width: 8.0),
                            DriverNames(driver.firstName, driver.secondName),
                            Expanded(child: SizedBox.shrink()),
                            Points(driver.points)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
