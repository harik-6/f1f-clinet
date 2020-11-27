import 'package:flutter/material.dart';

class LeagueRulesInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      child: ListView(
        children: [
          ListTile(
            title: Text(
                "Fantasy player can join the league before qualifying start on all the race weekends. "),
          ),
          ListTile(
              title: Text(
                  "Player will be asked to predict pole position, fastest lap and a random driver position.")),
          ListTile(
            title: Text(
                "At the end there will be some credit points awarded to the player and the player can choose as many driver as possible using that points."),
          ),
          ListTile(
            title: Text(
                "Each drvier will be given a credit point to choose from."),
          ),
          ListTile(
            title: Text(
                "Player can edit the prediction before the qualifying round starts."),
          ),
          ListTile(
              title: Text(
                  "Once the qualifying starts player can not edit the predictions.")),
          ListTile(
              title: Text(
                  "All the results will be available after the race ends.")),
          ListTile(
              title: Text(
                  "Click on Refresh button if results are unavailable after race.")),
          ListTile(
              title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1.Pole Prediction - 1 Point"),
              SizedBox(height: 5.0),
              Text("2.Fastest lap Prediction - 1 Point."),
              SizedBox(height: 5.0),
              Text("3.Driver position prediction - 10 Points"),
              SizedBox(height: 5.0),
              Text("4.Driver selection - Driver's race points.")
            ],
          )),
        ],
      ),
    );
  }
}
