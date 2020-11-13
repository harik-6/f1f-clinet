import 'package:flutter/material.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/screens/leaderboard/overall_board.dart';

class LeaderBoardWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _LeaderBoardWidget();
  }
}

class _LeaderBoardWidget extends State<LeaderBoardWidget> {
  int activeTab = 0;
  bool isLeaderBoardLoading = false;
 

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: isLeaderBoardLoading?PreLoader():OverallBoard(),
    );
  }
}