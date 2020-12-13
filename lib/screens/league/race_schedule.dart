import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/constants/app_enums.dart';
import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/services/native/tf_service.dart';
import 'package:flutter/material.dart';

class RaceSchedule extends StatefulWidget {
  final List<GrandPrix> list;
  RaceSchedule(this.list);
  @override
  _RaceScheduleState createState() => _RaceScheduleState();
}

class _RaceScheduleState extends State<RaceSchedule> {
  Widget _getNextRace() {
    List<GrandPrix> schraces = widget.list
        .where((gp) => gp.raceStatus == RACE_STATUS.scheduled)
        .toList();
    GrandPrix nextrace = schraces[schraces.length - 1];
    List<String> fmt = formatdateTime(nextrace.dateTime).split("T");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: DriverTile(
        childWidget: ListTile(
          tileColor: Colors.grey[900],
          title: Text(nextrace.gpName,
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
          subtitle: Text(
            nextrace.circuitName,
            style: TextStyle(fontSize: 13.0, color: Colors.white54),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(fmt[0]), SizedBox(height: 5.0), Text(fmt[1])],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Next race",
              style: headerText,
            ),
          ),
        ),
        _getNextRace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "All races",
              style: headerText,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              GrandPrix gp = widget.list[index];
              List<String> fmt = formatdateTime(gp.dateTime).split("T");
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Opacity(
                  opacity: gp.raceStatus == RACE_STATUS.scheduled ? 1.0 : 0.5,
                  child: DriverTile(
                    childWidget: ListTile(
                      tileColor: Colors.grey[900],
                      title: Text(gp.gpName,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                      subtitle: Text(
                        gp.circuitName,
                        style: TextStyle(fontSize: 13.0, color: Colors.white54),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fmt[0]),
                          SizedBox(height: 5.0),
                          Text(gp.raceStatus == RACE_STATUS.cancelled
                              ? "cancelled"
                              : fmt[1])
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
