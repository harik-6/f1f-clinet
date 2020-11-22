import 'package:flutter/material.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';

typedef void Callback(int param, GrandPrix param1);

class TrackList extends StatelessWidget {
  final int activeTrack;
  final Callback selectTrack;
  final List<GrandPrix> gps;
  TrackList(this.gps, this.activeTrack, this.selectTrack);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: gps.length,
              itemBuilder: (context, index) {
                GrandPrix gp = gps[index];
                return GestureDetector(
                  onTap: () {
                    selectTrack(index, gp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    child: Opacity(
                      opacity: index == activeTrack ? 1.0 : 0.4,
                      child: Container(
                        decoration:
                            index == activeTrack ? trackActiveBorder : null,
                        child: Text(gp.gpName.split(" ")[0] + " GP",
                            style: headerText),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
