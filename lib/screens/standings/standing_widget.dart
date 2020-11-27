import 'package:f1fantasy/services/result_service.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/constructor_model.dart';
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/screens/standings/constructor_standings.dart';
import 'package:f1fantasy/screens/standings/driver_standings.dart';

class StandingWidget extends StatefulWidget {
  @override
  _StandingWidget createState() {
    return _StandingWidget();
  }
}

class _StandingWidget extends State<StandingWidget>
    with AutomaticKeepAliveClientMixin<StandingWidget> {
  @override
  bool get wantKeepAlive => true;

  int activeTab = 0;
  bool isDrsLoading = true;
  bool isConsLoading = true;
  List<Driver> drivers = [];
  List<Constructor> constructors = [];

  final PageController pageController = PageController(initialPage: 0);

  void loadDriverStandings() async {
    ResultService service = new ResultService();
    List<Driver> drs = await service.getDriverStandings();
    setState(() {
      isDrsLoading = false;
      drivers = drs;
    });
  }

  void loadConstructorStandings() async {
    ResultService service = new ResultService();
    List<Constructor> cons = await service.getConstructorStandings();
    setState(() {
      isConsLoading = false;
      constructors = cons;
    });
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
    loadDriverStandings();
    loadConstructorStandings();
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
                            child: Text("Drivers", style: headerText)))),
                GestureDetector(
                    onTap: () {
                      changePage(1);
                    },
                    child: Opacity(
                        opacity: activeTab == 1 ? 1.0 : 0.4,
                        child: Container(
                            decoration:
                                activeTab == 1 ? trackActiveBorder : null,
                            child: Text("Constructors", style: headerText)))),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: changeActiveTab,
              controller: pageController,
              children: <Widget>[
                isDrsLoading
                    ? PreLoader()
                    : DriverStandings(drivers: this.drivers),
                isConsLoading
                    ? PreLoader()
                    : ConstructorStandings(constructors: this.constructors)
              ],
            ),
          )
        ],
      ),
    );
  }
}
