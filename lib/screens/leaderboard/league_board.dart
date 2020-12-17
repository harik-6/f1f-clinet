import 'package:formulafantasy/components/driver_names.dart';
import 'package:formulafantasy/components/driver_tile.dart';
import 'package:formulafantasy/components/points.dart';
import 'package:formulafantasy/components/position.dart';
import 'package:formulafantasy/components/preloader.dart';
import 'package:formulafantasy/constants/app_enums.dart';
import 'package:formulafantasy/models/grand_prix_model.dart';
import 'package:formulafantasy/models/league_leaderboard_model.dart';
import 'package:formulafantasy/services/leaderboard_service.dart';
import 'package:flutter/material.dart';

class LeagueLeaderBoard extends StatefulWidget {
  final GrandPrix activeLeague;
  LeagueLeaderBoard({this.activeLeague});
  @override
  LeagueBoardState createState() => LeagueBoardState();
}

class LeagueBoardState extends State<LeagueLeaderBoard> {
  LEAGUE_STATUS lstatus = LEAGUE_STATUS.loading;
  List<LLBoard> leaders = [];
  Future<void> _loadLeagueLeaderBoard() async {
    List<LLBoard> result = await new LeaderboardService()
        .getLeagueLeaderboard(widget.activeLeague);
    this.setState(() {
      lstatus = LEAGUE_STATUS.success;
      leaders = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLeagueLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          backgroundColor: Colors.grey[900],
          title: Text(widget.activeLeague.gpName),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Builder(
                builder: (context) {
                  switch (lstatus) {
                    case LEAGUE_STATUS.success:
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.0),
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
                                  LLBoard lead = leaders[index];
                                  String s = lead.name.split(" ")[0];
                                  String formatted =
                                      s[0].toUpperCase() + s.substring(1);
                                  return ListTile(
                                    title: DriverTile(
                                      childWidget: Row(
                                        children: <Widget>[
                                          Position(index + 1),
                                          SizedBox(width: 8.0),
                                          DriverNames("", formatted),
                                          Expanded(child: SizedBox.shrink()),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Points(lead.points)),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    case LEAGUE_STATUS.loading:
                      return PreLoader();
                    default:
                      return null;
                  }
                },
              )),
        ));
  }
}
