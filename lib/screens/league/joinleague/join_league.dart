import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/screens/league/joinleague/driver_selection.dart';
import 'package:f1fantasy/screens/league/joinleague/status_enum.dart';
import 'package:f1fantasy/screens/league/myleagues/my_drivers.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:f1fantasy/services/native/tf_service.dart';
import 'package:flutter/material.dart';

class JoinLeague extends StatefulWidget {
  final GrandPrix activeLeague;
  JoinLeague({Key key, this.activeLeague}) : super(key: key);
  @override
  _JoinLeagueState createState() => _JoinLeagueState();
}

class _JoinLeagueState extends State<JoinLeague> {
  STATUS leagueStatus = STATUS.haveto;
  List<Driver> drivers = [];
  Duration tillQualy;

  void checkForLeagueStatus() async {
    LeagueService service = LeagueService();
    List<Driver> drs = await service.readSelection(widget.activeLeague);
    if (drs.length > 0) {
      setState(() {
        drivers = drs;
        leagueStatus = STATUS.hasjoinedAlready;
      });
    }
  }

  bool _joinStatus() {
    DateTime now = DateTime.now().toLocal();
    DateTime qualyTime = widget.activeLeague.qualyTime.toLocal();
    if (now.isAfter(qualyTime)) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    this.checkForLeagueStatus();
  }

  @override
  Widget build(BuildContext context) {
    List<String> str = formatdateTime(widget.activeLeague.qualyTime).split("T");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
                  child: Text("Join before " + str[0] + " " + str[1],
                      style: TextStyle(fontSize: 17.0, color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(widget.activeLeague.gpName,
                        style: TextStyle(color: Colors.white54)))
              ],
            ),
            Builder(builder: (context) {
              switch (leagueStatus) {
                case STATUS.haveto:
                  return Opacity(
                    opacity: _joinStatus() ? 1.0 : 0.2,
                    child: Container(
                      height: 40.0,
                      width: 100.0,
                      child: IgnorePointer(
                        ignoring: !_joinStatus(),
                        child: RaisedButton(
                          onPressed: () {
                            if (_joinStatus()) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => DriverSelection(
                                            activeLeague: widget.activeLeague,
                                            callback: checkForLeagueStatus,
                                          )));
                            }
                          },
                          color: Colors.green[600],
                          highlightColor: Colors.black,
                          child: Text(
                            "Join",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                case STATUS.hasjoinedAlready:
                  return Container(
                    height: 40.0,
                    width: 100.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    MyDrivers(drivers: this.drivers)));
                      },
                      color: Colors.blue,
                      highlightColor: Colors.black,
                      child: Text(
                        "My Selection",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                default:
                  return null;
              }
            }),
          ],
        ),
      ],
    );
  }
}
