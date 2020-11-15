import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/drawer_start.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:f1fantasy/services/native/auth_service.dart';
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
  bool isgpsLoading = true;

  void changeActiveIndex(int newindex) {
    pageViewController.jumpToPage(newindex);
    setState(() {
      activeBottomIndex = newindex;
    });
  }

  void loadRaceSchedule() async {
    LeagueService gpService = LeagueService();
    List<GrandPrix> gpss = await gpService.getGrandPrixs();
    this.setState(() {
      isgpsLoading = false;
      gps = gpss;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadRaceSchedule();
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
          title: Text("F1 Fantasy league"),
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
                  title: Text("Home",
                      style: activeBottomIndex == 0
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null),
                  icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  title: Text("Races",
                      style: activeBottomIndex == 1
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null),
                  icon: Icon(Icons.flag)),
              BottomNavigationBarItem(
                  title: Text("Standings",
                      style: activeBottomIndex == 2
                          ? TextStyle(fontWeight: FontWeight.bold)
                          : null),
                  icon: Icon(Icons.leaderboard)),
              BottomNavigationBarItem(
                  title: Text("Leaderboard"), icon: Icon(Icons.view_headline))
            ]),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageViewController,
            children: [
              isgpsLoading ? PreLoader() : LeagueWidget(grandsprix: gps),
              isgpsLoading ? PreLoader() : ResultsWidget(gps: gps),
              StandingWidget(),
              LeaderBoardWidget()
            ],
          ),
        ));
  }
}
