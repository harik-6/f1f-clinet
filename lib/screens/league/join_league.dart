import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/models/user_league_details.dart';
import 'package:f1fantasy/screens/joinpages/page_view.dart';
import 'package:f1fantasy/screens/joinpages/view_selection.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';

class JoinLeague extends StatefulWidget {
  final GrandPrix activeLeague;
  JoinLeague({Key key, this.activeLeague}) : super(key: key);
  @override
  _JoinLeagueState createState() => _JoinLeagueState();
}

class _JoinLeagueState extends State<JoinLeague> {
  bool joined = false;
  LeagueDetails existing;
  void checkForLeagueStatus() async {
    LeagueService service = LeagueService();
    LeagueDetails lgdt = await service.readSelection(widget.activeLeague);
    if (lgdt != null) {
      setState(() {
        joined = true;
        existing = lgdt;
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

  void _navigatoSelection(BuildContext context, int rnum) {
    if (_joinStatus()) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => JoiningPageView(
                    callback: checkForLeagueStatus,
                    activeLeague: widget.activeLeague,
                    userRandomRound: rnum,
                  )));
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkForLeagueStatus();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text("Join before qualy starts",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 11.0),
                    child: Text(widget.activeLeague.gpName,
                        style: TextStyle(color: Colors.white54)))
              ],
            ),
            joined
                ? Container(
                    height: 40.0,
                    width: 100.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ViewMySelection(
                                    detail: existing,
                                    editCallback: (int nm) {
                                      _navigatoSelection(context, nm);
                                    })));
                      },
                      color: Colors.blue,
                      highlightColor: Colors.black,
                      child: Text(
                        "View",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Opacity(
                    opacity: _joinStatus() ? 1.0 : 0.2,
                    child: Container(
                      height: 40.0,
                      width: 100.0,
                      child: IgnorePointer(
                        ignoring: !_joinStatus(),
                        child: RaisedButton(
                          onPressed: () {
                            _navigatoSelection(context, -1);
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
                  )
          ],
        ),
      ],
    );
  }
}
