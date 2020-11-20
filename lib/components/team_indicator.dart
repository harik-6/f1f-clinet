import 'package:f1fantasy/constants/app_constants.dart';
import 'package:flutter/material.dart';

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
              BoxDecoration(color: AppConstants.teamColorsMap[teamName])),
    );
  }
}
