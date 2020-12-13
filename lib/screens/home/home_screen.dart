import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/constants/app_enums.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/home/drawer_start.dart';
import 'package:f1fantasy/screens/home/league_info.dart';
import 'package:f1fantasy/services/gp_service.dart';
import 'package:f1fantasy/services/native/auth_service.dart';
import 'package:f1fantasy/services/native/pref_service.dart';
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
  final PrefService _cacheService = PrefService();
  int activeBottomIndex = 0;
  List<GrandPrix> gps = [];
  GrandPrix activeGp;
  bool isgpsLoading = true;
  bool refreshing = false;

  void changeActiveIndex(int newindex) {
    pageViewController.jumpToPage(newindex);
    setState(() {
      activeBottomIndex = newindex;
    });
  }

  Future<void> _checkForDataUpdate(GrandPrix activeleague) async {
    if (activeleague != null) {
      DateTime now = DateTime.now().toLocal();
      DateTime racends =
          activeleague.dateTime.toLocal().add(Duration(hours: 3));
      if (now.isAfter(racends)) {
        await _cacheService.removeKey([
          AppConstants.cacheraceschedule,
          AppConstants.cachedriverstandings,
          AppConstants.cacheconstructorstandings,
          AppConstants.cacheleaderboard,
          AppConstants.cacheuserleagues
        ]);
        await _subLoadFunction();
      }
    }
    return;
  }

  Future<GrandPrix> _subLoadFunction() async {
    setState(() {
      isgpsLoading = true;
    });
    GpService gpService = GpService();
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

  Future<void> loadRaceSchedule() async {
    GrandPrix present = await _subLoadFunction();
    await _checkForDataUpdate(present);
    return;
  }

  Future<void> _subRefresh() async {
    setState(() {
      refreshing = true;
    });
    switch (activeBottomIndex) {
      case 2:
        await _cacheService.removeKey([
          AppConstants.cachedriverstandings,
          AppConstants.cacheconstructorstandings
        ]);
        break;
      case 3:
        await _cacheService.removeKey([AppConstants.cacheleaderboard]);
        break;
      default:
        break;
    }
    setState(() {
      refreshing = false;
    });
    return;
  }

  Future<void> _regreshScreen() async {
    if (activeBottomIndex == 0 || activeBottomIndex == 1) {
      await _cacheService.removeKey(
          [AppConstants.cacheraceschedule, AppConstants.cacheuserleagues]);
      await loadRaceSchedule();
    } else {
      await _subRefresh();
    }
    return;
  }

  void _actionSelected(int value, BuildContext context) async {
    if (value == 1) {
      await _regreshScreen();
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                contentPadding: EdgeInsets.all(8.0),
                title: Text("How league works?"),
                content: LeagueRulesInfo(),
                actions: [
                  RaisedButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
          barrierDismissible: true);
    }
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
          title: Text("F1 Fantasy"),
          actions: [
            PopupMenuButton(
                color: Colors.grey[900],
                offset: Offset(20.0, 50.0),
                onSelected: (value) {
                  _actionSelected(value, context);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Refresh"),
                            SizedBox(width: 10.0),
                            Icon(Icons.refresh, size: 18.0)
                          ],
                        ),
                        textStyle: headerText),
                    PopupMenuItem(
                        value: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("League"),
                            SizedBox(width: 10.0),
                            Icon(Icons.info_outlined, size: 18.0)
                          ],
                        ),
                        textStyle: headerText)
                  ];
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
            refreshing ? PreLoader() : StandingWidget(),
            refreshing ? PreLoader() : LeaderBoardWidget()
          ],
        )));
  }
}
