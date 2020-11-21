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
    with AutomaticKeepAliveClientMixin {
  STATUS status = STATUS.loading;
  List<Leaderboard> leaders = [];

  @override
  bool get wantKeepAlive => true;

  void loadLeaderBoard() async {
    setState(() {
      status = STATUS.loading;
    });
    List<Leaderboard> ls = await LeagueService().getLeaderboard();
    setState(() {
      leaders = ls;
      status = STATUS.success;
    });
    return;
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
                          child: Text("Races",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text("Pts",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
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
                                  SizedBox(width: 5.0),
                                  SizedBox(width: 8.0),
                                  DriverNames("", lead.name),
                                  Expanded(child: SizedBox.shrink()),
                                  Points(2),
                                  Points(lead.points)
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
          }
          return null;
        }));
  }
}
