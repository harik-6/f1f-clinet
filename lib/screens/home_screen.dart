import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/app_enums.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/drawer_start.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:f1fantasy/services/native/auth_service.dart';
import 'package:f1fantasy/services/native/data_service.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/screens/leaderboard/leaderboard_widget.dart';
import 'package:f1fantasy/screens/league/league_widget.dart';
import 'package:f1fantasy/screens/results/results_widget.dart';
import 'package:f1fantasy/screens/standings/standing_widget.dart';

class AppHome extends StatefulWidget {
  AppHome({Key key}) : super(key: key);

  @override
  _AppHome createState() => _AppHome();
}

class _AppHome extends State<AppHome> {
  final PageController pageViewController = new PageController(initialPage: 0);
  int activeBottomIndex = 0;
  List<GrandPrix> gps = [];
  GrandPrix activeGp;
  bool isgpsLoading = true;

  void changeActiveIndex(int newindex) {
    pageViewController.jumpToPage(newindex);
    setState(() {
      activeBottomIndex = newindex;
    });
  }

  Future<void> updateCacheStatus(GrandPrix active) async {
    bool isDataUpdated = await DataService().updateCacheStatus(active);
    if (isDataUpdated) {
      await this.loadRaceSchedule();
    }
    return;
  }

  Future<void> initDataCheck() async {
    GrandPrix active = await this.loadRaceSchedule();
    if (active != null) {
      await updateCacheStatus(active);
    }
    return;
  }

  Future<GrandPrix> loadRaceSchedule() async {
    setState(() {
      isgpsLoading = true;
    });
    LeagueService gpService = LeagueService();
    List<GrandPrix> gpss = await gpService.getGrandPrixs();
    List<GrandPrix> active = gpss.reversed
        .where((gp) => gp.raceStatus == RACE_STATUS.scheduled)
        .toList();
    GrandPrix present = active.length > 0 ? active[0] : null;
    this.setState(() {
      gps = gpss;
      activeGp = present;
      isgpsLoading = false;
    });
    return present;
  }

  @override
  void initState() {
    super.initState();
    this.initDataCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          titleSpacing: 0.0,
          backgroundColor: Colors.grey[900],
          title: Text("F1 Fantasy"),
          actions: [
            IconButton(
                icon: Icon(Icons.info_outline),
                iconSize: 16.0,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text("How league works?"),
                            content: Container(
                              height: 230.0,
                              child: ListView(
                                children: [
                                  ListTile(
                                      title: Text(
                                          "1.User has to enter the league before qualying starts, on the race weekend.")),
                                  ListTile(
                                      title: Text(
                                          "2.List of drivers will be available to choose.")),
                                  ListTile(
                                      title: Text(
                                          "3.Choose in such a way to maximize the point scoring")),
                                  ListTile(
                                      title: Text(
                                          "\n4.After the race ends,user will be awarded with the points scored by the driver during that race.")),
                                ],
                              ),
                            ),
                            actions: [
                              RaisedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          ),
                      barrierDismissible: true);
                })
          ],
        ),
        drawer: Container(
            width: 200.0,
            child: Drawer(child: SideDrawer(new AuthService().getUser()))),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white24,
            currentIndex: activeBottomIndex,
            onTap: changeActiveIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text("Home",
                      style: activeBottomIndex == 0
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null),
                  icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text("Races",
                      style: activeBottomIndex == 1
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null),
                  icon: Icon(Icons.flag)),
              BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text("Standings",
                      style: activeBottomIndex == 2
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null),
                  icon: Icon(Icons.leaderboard)),
              BottomNavigationBarItem(
                  // ignore: deprecated_member_use
                  title: Text("Leaderboard"),
                  icon: Icon(Icons.view_headline))
            ]),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageViewController,
          children: [
            isgpsLoading
                ? PreLoader()
                : LeagueWidget(grandsprix: gps, activeLeague: activeGp),
            isgpsLoading ? PreLoader() : ResultsWidget(gps: gps),
            StandingWidget(),
            LeaderBoardWidget()
          ],
        )));
  }
}
