import 'package:formulafantasy/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TeamIcon extends StatelessWidget {
  final String teamName;
  final double padding;
  TeamIcon(this.teamName, this.padding);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Image(
          image: AssetImage(AppConstants.teamImages[teamName]),
          width: 25.0,
          height: 25.0,
        ));
  }
}
