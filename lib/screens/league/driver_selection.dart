import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/league_driver_model.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/components/team_indicator.dart';
import 'package:f1fantasy/models/driver_model.dart';

class DriverSelection extends StatefulWidget {
  final GrandPrix activeLeague;
  DriverSelection({Key key,this.activeLeague}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DriverSelection();
  }
}

class _DriverSelection extends State<DriverSelection> {
  bool isDrsLoading = true;
  bool isJoining = false;
  List<LeagueDriver> drivers = [];
  double totalCredits = 10.0;

  void loadAllDriver() async {
    LeagueService service = new LeagueService();
    List<LeagueDriver> drs = await service.getDriverCredits(1);
    setState(() {
      drivers = drs;
      isDrsLoading = false;
    });
  }

  void addToList(int index) {
    List<LeagueDriver> present = drivers;
    present[index].isSelected = true;
    double credits = totalCredits - present[index].creditPoints;
    setState(() {
      drivers = present;
      totalCredits = credits;
    });
  }

  void removeFromList(int index) {
    List<LeagueDriver> present = drivers;
    present[index].isSelected = false;
    double credits = totalCredits + present[index].creditPoints;
    setState(() {
      drivers = present;
      totalCredits = credits;
    });
  }

  bool isActive(LeagueDriver selection) {
    return (selection.isSelected) || (selection.creditPoints <= totalCredits);
  }

  void joinLeague() async{
    LeagueService service = new LeagueService();
    setState(() {
     isJoining = true; 
    });
    await service.joinLeague(drivers, widget.activeLeague);
  }

  @override
  void initState() {
    super.initState();
    loadAllDriver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose driver"),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.black,
      floatingActionButton: isJoining?SizedBox.shrink():Container(
        width: double.infinity,
        height: 50.0,
        child: RaisedButton(
          onPressed: joinLeague,
          color: Colors.green[600],
          child: Text(
            "Join league",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: isJoining?PreLoader("Joining league"):SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 20.0, right: 90.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total credits available", style: headerText),
                    Text(totalCredits.toString(), style: headerText)
                  ],
                ),
              ),
              Expanded(
                child: isDrsLoading
                    ? PreLoader()
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListView.builder(
                          itemCount: drivers.length,
                          itemBuilder: (context, index) {
                            LeagueDriver dr = drivers[index];
                            Driver driver = dr.driver;
                            bool active = isActive(dr);
                            return Container(
                              key: Key(driver.firstName),
                              width: double.infinity,
                              height: 80.0,
                              child: Opacity(
                                opacity: active ? 1.0 : 0.5,
                                child: ListTile(
                                  title: DriverTile(
                                    childWidget: Row(
                                      children: <Widget>[
                                        SizedBox(width: 10.0),
                                        TeamIndicator(driver.team),
                                        SizedBox(width: 8.0),
                                        DriverNames(driver.firstName,
                                            driver.secondName),
                                        Expanded(child: SizedBox.shrink()),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                              dr.creditPoints.toString(),
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        IgnorePointer(
                                          ignoring: !active,
                                          child: dr.isSelected
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .horizontal_rule_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    removeFromList(index);
                                                  },
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.green,
                                                  ),
                                                  onPressed: () {
                                                    addToList(index);
                                                  },
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}
