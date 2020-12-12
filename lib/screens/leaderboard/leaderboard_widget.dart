import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/components/position.dart';
import 'package:f1fantasy/models/leaderboard_model.dart';

enum STATUS { loading, failed, success }

class LeaderBoardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LeaderBoardWidget();
  }
}

class _LeaderBoardWidget extends State<LeaderBoardWidget>
    with AutomaticKeepAliveClientMixin<LeaderBoardWidget> {
  @override
  bool get wantKeepAlive => true;
  STATUS status = STATUS.loading;
  List<Leaderboard> leaders = [];
  Leaderboard myPosition;

  void loadLeaderBoard() async {
    setState(() {
      status = STATUS.loading;
    });
    Map ls = await LeagueService().getLeaderboard();
    setState(() {
      leaders = ls["leaderboard"];
      myPosition = ls["myPosition"];
      status = STATUS.success;
    });
    return;
  }

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
  void initState() {
    super.initState();
    this.loadLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Builder(builder: (context) {
          switch (status) {
            case STATUS.loading:
              return PreLoader();
            case STATUS.success:
              return Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text("Pts",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text("G/L",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My Position",
                        style: headerText,
                      ),
                    ),
                  ),
                  ListTile(
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
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Leaderboard",
                        style: headerText,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: leaders.length,
                        itemBuilder: (context, index) {
                          Leaderboard lead = leaders[index];
                          return ListTile(
                            title: DriverTile(
                              childWidget: Row(
                                children: <Widget>[
                                  Position(index + 1),
                                  SizedBox(width: 8.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(lead.name.split(" ")[0],
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(height: 5.0),
                                      Text(
                                          lead.leagueCount.toString() +
                                              " Leagues",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white54))
                                    ],
                                  ),
                                  Expanded(child: SizedBox.shrink()),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Points(lead.points)),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: _getProgressIcon(lead))
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            default:
              return null;
          }
        }));
  }
}
