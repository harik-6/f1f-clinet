import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/league/joinleague/driver_selection.dart';
import 'package:f1fantasy/services/native/pref_service.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/constants/app_constants.dart';

class JoinLeague extends StatefulWidget {
  final GrandPrix activeLeague;
  JoinLeague({Key key, this.activeLeague}) : super(key: key);
  @override
  _JoinLeagueState createState() => _JoinLeagueState();
}

class _JoinLeagueState extends State<JoinLeague> {
  bool hasJoined = false;

  void checkForLeagueStatus() async {
    String cache = await PrefService().readDate(cache_join_league);
    if (cache != null) {
      setState(() {
        hasJoined = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkForLeagueStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
              child: Text(widget.activeLeague.gpName,
                  style: TextStyle(fontSize: 20.0)),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(widget.activeLeague.circuitName,
                    style: TextStyle(color: Colors.white70)))
          ],
        ),
        hasJoined
            ? Container(
                height: 40.0,
                width: 100.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => DriverSelection(
                                activeLeague: widget.activeLeague)));
                  },
                  color: Colors.green[600],
                  highlightColor: Colors.black,
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Column(children: [
                Icon(Icons.check_circle_outlined, color: Colors.green),
                GestureDetector(
                  onTap: () {},
                  child: Text("View drivers",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white54)),
                )
              ])
      ],
    );
  }
}
