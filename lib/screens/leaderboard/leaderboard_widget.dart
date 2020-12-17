import 'package:formulafantasy/components/driver_tile.dart';
import 'package:formulafantasy/constants/styles.dart';
import 'package:formulafantasy/models/grand_prix_model.dart';
import 'package:formulafantasy/screens/leaderboard/league_board.dart';
import 'package:formulafantasy/services/leaderboard_service.dart';
import 'package:flutter/material.dart';
import 'package:formulafantasy/components/preloader.dart';
import 'package:formulafantasy/models/leaderboard_model.dart';
import 'individual_board.dart';

enum STATUS { loading, failed, success }

class LeaderBoardWidget extends StatefulWidget {
  final List<GrandPrix> leagues;
  LeaderBoardWidget({this.leagues});
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
  int activeTab = 0;
  final PageController pageController = PageController(initialPage: 0);

  void loadLeaderBoard() async {
    setState(() {
      status = STATUS.loading;
    });
    Map ls = await LeaderboardService().getLeaderboard();
    setState(() {
      leaders = ls["leaderboard"];
      myPosition = ls["myPosition"];
      status = STATUS.success;
    });
    return;
  }

  void changeActiveTab(newtab) {
    setState(() {
      activeTab = newtab;
    });
  }

  void changePage(int newindex) {
    pageController.jumpToPage(newindex);
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
      child: Column(
        children: <Widget>[
          Container(
            height: 60.0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      changePage(0);
                    },
                    child: Opacity(
                        opacity: activeTab == 0 ? 1.0 : 0.4,
                        child: Container(
                            decoration:
                                activeTab == 0 ? trackActiveBorder : null,
                            child: Text("Individual", style: headerText)))),
                GestureDetector(
                    onTap: () {
                      changePage(1);
                    },
                    child: Opacity(
                        opacity: activeTab == 1 ? 1.0 : 0.4,
                        child: Container(
                            decoration:
                                activeTab == 1 ? trackActiveBorder : null,
                            child: Text("Leagues", style: headerText)))),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: changeActiveTab,
              controller: pageController,
              children: <Widget>[
                Builder(builder: (context) {
                  switch (status) {
                    case STATUS.loading:
                      return PreLoader();
                    case STATUS.success:
                      return IndividualBoard(
                          leaders: leaders, myPosition: myPosition);
                    default:
                      return null;
                  }
                }),
                Builder(builder: (context) {
                  switch (widget.leagues.length) {
                    case 0:
                      return Center(
                        child: Text(
                          "League wise leaderboard will be updated soon.",
                          style: headerText,
                        ),
                      );
                    default:
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.leagues.length,
                              itemBuilder: (context, index) {
                                GrandPrix league = widget.leagues[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 16.0),
                                  child: DriverTile(
                                    childWidget: ListTile(
                                      tileColor: Colors.grey[900],
                                      title: Text(league.gpName,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white)),
                                      subtitle: Text(league.circuitName,
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white54)),
                                      trailing: IconButton(
                                        icon: Icon(Icons.navigate_next,
                                            color: Colors.green),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      LeagueLeaderBoard(
                                                        activeLeague: league,
                                                      )));
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                  }
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
