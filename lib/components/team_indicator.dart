import 'package:flutter/material.dart';
import 'package:f1fantasy/constants/team_constants.dart';

class TeamIndicator extends StatelessWidget {
  final String teamName;
  TeamIndicator(this.teamName);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5.0,
      height: 30.0,
      child: DecoratedBox(
          decoration:
              BoxDecoration(color: TeamConstants.teamColorsMap[teamName])),
    );
  }
}
