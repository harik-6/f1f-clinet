import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/app_enums.dart';
import 'package:f1fantasy/models/driver_credit_model.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/screens/joinpages/custom_selection.dart';
import 'package:f1fantasy/screens/joinpages/driver_selection.dart';
import 'package:f1fantasy/screens/joinpages/result.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class JoiningPageView extends StatefulWidget {
  final Function callback;
  final GrandPrix activeLeague;
  final int userRandomRound;
  JoiningPageView({this.callback, this.activeLeague, this.userRandomRound});
  @override
  JoiningPageViewState createState() => JoiningPageViewState();
}

class JoiningPageViewState extends State<JoiningPageView> {
  final PageController pageViewController = new PageController(initialPage: 0);
  int currentPage = 0;
  List<DriverCredit> drCredits = [];
  String fastestDriver;
  String poleDriver;
  String customDriver;
  int customDriverPosition;
  LEAGUE_STATUS lstatus = LEAGUE_STATUS.loading;

  void _loadAllDriver() async {
    LeagueService service = new LeagueService();
    List<DriverCredit> drs = await service.getDriverCredits(
        widget.activeLeague.round, widget.activeLeague.dateTime.year);
    setState(() {
      drCredits = drs;
      lstatus = LEAGUE_STATUS.inprocess;
    });
  }

  void _joinLeague(List<DriverCredit> chosen) async {
    setState(() {
      lstatus = LEAGUE_STATUS.joining;
    });
    LeagueService service = new LeagueService();
    bool isSuccess = await service.joinLeague(chosen, poleDriver, fastestDriver,
        customDriver, customDriverPosition, widget.activeLeague);
    if (isSuccess) {
      widget.callback();
    }
    setState(() {
      lstatus = isSuccess ? LEAGUE_STATUS.success : LEAGUE_STATUS.failure;
    });
  }

  void _setCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void _pageControllerCallback(int page) {
    pageViewController.jumpToPage(page);
    _setCurrentPage(page);
  }

  void _setCustomPositionNumber(int already) {
    int n = already;
    if (already == -1) {
      Random random = new Random();
      n = random.nextInt(20) + 1;
    }
    setState(() {
      customDriverPosition = n;
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
    _setCustomPositionNumber(widget.userRandomRound);
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
          child: Builder(builder: (context) {
            switch (lstatus) {
              case LEAGUE_STATUS.loading:
                return PreLoader();
              case LEAGUE_STATUS.inprocess:
                return Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          currentPage > 0
                              ? IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: () {
                                    _pageControllerCallback(currentPage - 1);
                                  })
                              : SizedBox.shrink(),
                          currentPage < 3
                              ? IconButton(
                                  icon: Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                  onPressed: () {
                                    _pageControllerCallback(currentPage + 1);
                                  })
                              : SizedBox.shrink()
                        ]),
                    Expanded(
                      child: PageView(
                        onPageChanged: _setCurrentPage,
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
                                "Who will finish the race at position number $customDriverPosition ?",
                          ),
                          DriverSelection(
                            drCredits: drCredits,
                            callback: _joinLeague,
                          )
                        ],
                      ),
                    )
                  ],
                );
              case LEAGUE_STATUS.joining:
                return PreLoader("Joining the league");
              case LEAGUE_STATUS.success:
                return LeagueResult(status: true);
              case LEAGUE_STATUS.failure:
                return LeagueResult(status: false, callback: _loadAllDriver);
              default:
                return null;
            }
          }),
        ));
  }
}
