import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/user_league_details.dart';
import 'package:f1fantasy/models/user_league_model.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/team_indicator.dart';
import 'package:f1fantasy/models/driver_model.dart';

class DetailedLeagueDetails extends StatefulWidget {
  final League league;
  final LeagueDetails leagueDetails;
  DetailedLeagueDetails({this.league, this.leagueDetails});
  @override
  _DetailedLeagueDetailsState createState() => _DetailedLeagueDetailsState();
}

class _DetailedLeagueDetailsState extends State<DetailedLeagueDetails> {
  bool isLoading = true;
  LeagueDetails detail;

  void _setLeagueDetails(LeagueDetails dt) {
    setState(() {
      isLoading = false;
      detail = dt;
    });
  }

  void _loadLeagueDetail() async {
    LeagueDetails details =
        await LeagueService().getLeagueDetails(widget.league);
    _setLeagueDetails(details);
  }

  @override
  void initState() {
    super.initState();
    if (widget.league != null) {
      _loadLeagueDetail();
    } else {
      _setLeagueDetails(widget.leagueDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("League result"),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: isLoading
              ? PreLoader()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5.0),
                        child: Text("Pts"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text("Pole position", style: headerText),
                    ),
                    ListTile(
                      title: DriverTile(
                        childWidget: Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            TeamIndicator(detail.fastest.team),
                            SizedBox(width: 8.0),
                            DriverNames(detail.fastest.firstName,
                                detail.fastest.secondName),
                            Expanded(child: SizedBox.shrink()),
                            detail.poleResult
                                ? Icon(Icons.check, color: Colors.green[600])
                                : Icon(Icons.close, color: Colors.red),
                            Points(detail.poleResult ? 1 : 0)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
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
                            detail.fastestResult
                                ? Icon(Icons.check, color: Colors.green[600])
                                : Icon(Icons.close, color: Colors.red),
                            Points(detail.fastestResult ? 1 : 0)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                          "Driver finished at position " +
                              detail.userDriverPosition.toString(),
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
                            detail.userDriverResult
                                ? Icon(Icons.check, color: Colors.green[600])
                                : Icon(Icons.close, color: Colors.red),
                            Points(detail.userDriverResult ? 10 : 0)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text("Driver selected (Race points)",
                          style: headerText),
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
                                  DriverNames(
                                      driver.firstName, driver.secondName),
                                  Expanded(child: SizedBox.shrink()),
                                  Points(driver.points)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
        ));
  }
}
