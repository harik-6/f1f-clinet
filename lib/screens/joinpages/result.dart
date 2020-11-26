import 'package:flutter/material.dart';

class LeagueResult extends StatelessWidget {
  final bool status;
  LeagueResult(this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                status?Icon(Icons.check_circle,color: Colors.green,size: 80.0):
                Icon(Icons.warning_amber_outlined,color: Colors.white24,size: 60.0),
                SizedBox(height: 20.0),
                Text(status?"Joined the league":"Sorry!! Something went wrong",style: TextStyle(
                  fontSize: 18.0
                ))
              ],
            )
    );
  }
}
