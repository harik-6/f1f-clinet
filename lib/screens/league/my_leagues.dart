import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/user_league_model.dart';
import 'package:f1fantasy/screens/league/league_details.dart';
import 'package:f1fantasy/services/league_service.dart';
import 'package:flutter/material.dart';

enum STATUS { loading, loaded }

class MyLeagues extends StatefulWidget {
  final GrandPrix active;
  MyLeagues({this.active});
  @override
  _MyLeaguesState createState() => _MyLeaguesState();
}

class _MyLeaguesState extends State<MyLeagues>
    with AutomaticKeepAliveClientMixin<MyLeagues> {
  @override
  bool get wantKeepAlive => true;
  STATUS status = STATUS.loading;
  List<League> myLeagues;

  void loadAllMyLeagues() async {
    List<League> all = await LeagueService().getUserLeagues();
    setState(() {
      status = STATUS.loaded;
      myLeagues = all;
    });
  }

  Widget _getLeagueList() {
    List<League> finishedLeagues =
        myLeagues.where((lg) => lg.round != widget.active.round).toList();
    if (finishedLeagues.length == 0) {
      return Center(
          child: Text(
        "Leagues will be displayed after the next league ends",
        style: headerText,
      ));
    }
    return ListView.builder(
      itemCount: finishedLeagues.length,
      itemBuilder: (context, index) {
        League league = myLeagues[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: DriverTile(
            childWidget: ListTile(
              tileColor: Colors.grey[900],
              title: Text(league.points.toString() + " Pts",
                  style: TextStyle(color: Colors.white)),
              subtitle:
                  Text(league.gpName, style: TextStyle(color: Colors.white54)),
              trailing: IconButton(
                icon: Icon(Icons.navigate_next, color: Colors.green),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => DetailedLeagueDetails(
                                league: league,
                              )));
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this.loadAllMyLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        switch (status) {
          case STATUS.loading:
            return PreLoader();
          case STATUS.loaded:
            return myLeagues.length == 0
                ? Center(
                    child: Text(
                      "Seems like you have not participated in any league.",
                      style: headerText,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: _getLeagueList(),
                      )
                    ],
                  );
          default:
            return null;
        }
      },
    );
  }
}
