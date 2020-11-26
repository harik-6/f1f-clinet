import 'package:f1fantasy/models/driver_credit_model.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/joinpages/custom_selection.dart';
import 'package:f1fantasy/screens/joinpages/driver_selection.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class JoiningPageView extends StatefulWidget {
  final Function callback;
  final GrandPrix activeLeague;
  JoiningPageView({this.callback, this.activeLeague});
  @override
  JoiningPageViewState createState() => JoiningPageViewState();
}

class JoiningPageViewState extends State<JoiningPageView> {
  final PageController pageViewController = new PageController(initialPage: 0);
  bool isDrsLoading = true;
  int currentPage = 0;
  List<DriverCredit> drCredits = [];
  String fastestDriver;
  String poleDriver;
  String customDriver;
  int customDriverPosition;

  void _loadAllDriver() async {
    LeagueService service = new LeagueService();
    List<DriverCredit> drs = await service.getDriverCredits(
        widget.activeLeague.round, widget.activeLeague.dateTime.year);
    setState(() {
      drCredits = drs;
      isDrsLoading = false;
    });
  }

  void _joinLeague(List<DriverCredit> chosen) async {
    LeagueService service = new LeagueService();
    bool isSuccess = await service.joinLeague(chosen, widget.activeLeague);
    print("join league success " + isSuccess.toString());
    widget.callback();
  }

  void _pageControllerCallback(int page) {
    pageViewController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  void _setCustomPositionNumber() {
    Random random = new Random();
    setState(() {
      customDriverPosition = random.nextInt(20) + 1;
    });
  }

  void _polePositionCallback(String drId) {
    setState(() {
      poleDriver = drId;
    });
  }

  void _fastestLapCallback(String drId) {
    setState(() {
      fastestDriver = drId;
    });
  }

  void _customRacePositionCallback(String drId) {
    setState(() {
      customDriver = drId;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAllDriver();
    _setCustomPositionNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          backgroundColor: Colors.grey[900],
          title: Text("Join league"),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Row(children: [
              IconButton(
                  icon: Icon(Icons.navigate_next, color: Colors.white),
                  onPressed: () {
                    _pageControllerCallback(currentPage + 1);
                  }),
              IconButton(
                  icon: Icon(Icons.navigate_before, color: Colors.white),
                  onPressed: () {
                    _pageControllerCallback(currentPage - 1);
                  })
            ]),
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageViewController,
              children: [
                CustomPosition(
                  drCredits: drCredits,
                  callback: _polePositionCallback,
                  roundtype: "Who will take the Pole?",
                ),
                CustomPosition(
                  drCredits: drCredits,
                  callback: _fastestLapCallback,
                  roundtype: "Who will set the Fastest Lap?",
                ),
                CustomPosition(
                  drCredits: drCredits,
                  callback: _customRacePositionCallback,
                  roundtype:
                      "Who will finish at position number $customDriverPosition ?",
                ),
                DriverSelection(
                  drCredits: drCredits,
                  callback: _joinLeague,
                )
              ],
            )
          ],
        )));
  }
}
