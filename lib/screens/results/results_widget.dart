import 'package:f1fantasy/constants/app_enums.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/models/race_result_model.dart';
import 'package:f1fantasy/screens/results/grand_prix_list.dart';
import 'package:f1fantasy/screens/results/race_standings.dart';
import 'package:f1fantasy/services/result_service.dart';

class ResultsWidget extends StatefulWidget {
  final List<GrandPrix> gps;
  ResultsWidget({Key key, this.gps}) : super(key: key);
  @override
  _ResultsWidget createState() => _ResultsWidget();
}

class _ResultsWidget extends State<ResultsWidget> {
  int trackSelected = 0;
  bool isLoading = true;
  int gpRound = 0;
  List<GrandPrix> completed = [];
  Map<int, List<RaceResult>> results = <int, List<RaceResult>>{};
  final PageController pageController = PageController(initialPage: 0);

  void selectTrack(int newtrack, GrandPrix gpp) {
    int round = gpp.round;
    setState(() {
      trackSelected = newtrack;
      gpRound = round;
    });
    getRaceResults(round, gpp.dateTime.year);
  }

  void getRaceResults(int round, int year) async {
    if (!results.containsKey(round)) {
      setState(() {
        isLoading = true;
      });
      ResultService service = ResultService();
      List<RaceResult> raceResults = await service.getraceResults(round, year);
      Map<int, List<RaceResult>> existing = this.results;
      existing[round] = raceResults;
      setState(() {
        results = existing;
        isLoading = false;
      });
    }
  }

  List<GrandPrix> _filterCompletedRaces() {
    List<GrandPrix> filtered = widget.gps
        .where((GrandPrix gp) => gp.raceStatus == RACE_STATUS.completed)
        .toList();
    setState(() {
      completed = filtered;
    });
    return filtered;
  }

  @override
  void initState() {
    super.initState();
    List<GrandPrix> x = _filterCompletedRaces();
    this.setState(() {
      gpRound = x[trackSelected].round;
    });
    getRaceResults(x[trackSelected].round, x[trackSelected].dateTime.year);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: completed.length == 0
          ? Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flag, color: Colors.white, size: 36.0),
                    SizedBox(height: 10.0),
                    Text("Race results will be updated soon",
                        style: TextStyle(fontSize: 16.0))
                  ],
                ))
              ],
            )
          : Column(
              children: <Widget>[
                TrackList(completed, trackSelected, selectTrack),
                Expanded(
                    child: isLoading
                        ? PreLoader()
                        : RaceStandings(results: this.results[gpRound]))
              ],
            ),
    );
  }
}
