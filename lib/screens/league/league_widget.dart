import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/league/joinleague/join_league.dart';
import 'package:f1fantasy/screens/league/race_schedule.dart';
import 'package:f1fantasy/screens/league/myleagues/my_leagues.dart';
import 'package:flutter/material.dart';

class LeagueWidget extends StatefulWidget {
  final List<GrandPrix> grandsprix;
  final GrandPrix activeLeague;
  LeagueWidget({Key key, this.grandsprix, this.activeLeague}) : super(key: key);

  @override
  _LeagueWidget createState() => _LeagueWidget();
}

class _LeagueWidget extends State<LeagueWidget>
    with AutomaticKeepAliveClientMixin {
  int activeTab = 0;
  final PageController pageController = PageController(initialPage: 0);

  @override
  bool get wantKeepAlive => true;

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.activeLeague != null
              ? JoinLeague(activeLeague: widget.activeLeague)
              : SizedBox.shrink(),
          SizedBox(height: 12.0),
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
                            child: Text("Races", style: headerText)))),
                GestureDetector(
                    onTap: () {
                      changePage(1);
                    },
                    child: Opacity(
                        opacity: activeTab == 1 ? 1.0 : 0.4,
                        child: Container(
                            decoration:
                                activeTab == 1 ? trackActiveBorder : null,
                            child: Text("My leagues", style: headerText)))),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: changeActiveTab,
            children: [RaceSchedule(widget.grandsprix), MyLeagues()],
          ))
        ],
      ),
    );
  }
}
