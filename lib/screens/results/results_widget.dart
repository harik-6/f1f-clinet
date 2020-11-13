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

class _ResultsWidget extends State<ResultsWidget>
    with AutomaticKeepAliveClientMixin {
  int trackSelected = 0;
  bool isLoading = true;
  int gpRound = 0;
  Map<int, List<RaceResult>> results = <int, List<RaceResult>>{};
  final PageController pageController = PageController(initialPage: 0);

  void selectTrack(int newtrack) {
    int round = widget.gps[newtrack].round;
    setState(() {
      trackSelected = newtrack;
      gpRound = round;
    });
    getRaceResults(round);
  }

  void getRaceResults(int round) async {
    if (!results.containsKey(round)) {
      setState(() {
        isLoading = true;
      });
      ResultService service = ResultService();
      List<RaceResult> raceResults = await service.getraceResults(round);
      Map<int, List<RaceResult>> existing = this.results;
      existing[round] = raceResults;
      setState(() {
        results = existing;
        isLoading = false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    this.setState(() {
     gpRound = widget.gps[trackSelected].round; 
    });
    getRaceResults(widget.gps[trackSelected].round);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          TrackList(widget.gps, trackSelected, selectTrack),
          Expanded(
              child: isLoading
                  ? PreLoader()
                  : RaceStandings(results: this.results[gpRound]))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
