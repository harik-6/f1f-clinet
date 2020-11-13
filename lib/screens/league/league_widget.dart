import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/league/race_schedule.dart';
import 'package:f1fantasy/screens/league/my_leagues.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/screens/league/driver_selection.dart';

class LeagueWidget extends StatefulWidget {
  final List<GrandPrix> grandsprix;
  LeagueWidget({Key key, this.grandsprix}) : super(key: key);

  @override
  _LeagueWidget createState() => _LeagueWidget();
}

class _LeagueWidget extends State<LeagueWidget>
    with AutomaticKeepAliveClientMixin {
  int activeTab = 0;
  final PageController pageController = PageController(initialPage: 0);
  GrandPrix activeLeague;

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
    List<GrandPrix> active =
        widget.grandsprix.reversed.where((gp) => gp.active == true).toList();
    if (active.length != 0) {
      setState(() {
        activeLeague = active[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
                    child: Text(activeLeague.gpName,
                        style: TextStyle(fontSize: 20.0)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(activeLeague.circuitName,
                          style: TextStyle(color: Colors.white70)))
                ],
              ),
              Container(
                height: 40.0,
                width: 100.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                DriverSelection(activeLeague: activeLeague)));
                  },
                  color: Colors.green[600],
                  highlightColor: Colors.black,
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
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
            children: [
              RaceSchedule(widget.grandsprix),
              MyLeagues(widget.grandsprix)
            ],
          ))
        ],
      ),
    );
  }
}
