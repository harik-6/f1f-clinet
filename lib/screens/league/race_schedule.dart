import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/constants/month_constants.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:flutter/material.dart';

class RaceSchedule extends StatefulWidget {
  final List<GrandPrix> list;
  RaceSchedule(this.list);
  @override
  _RaceScheduleState createState() => _RaceScheduleState();
}

class _RaceScheduleState extends State<RaceSchedule> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              GrandPrix gp = widget.list[index];
              DateTime date = gp.dateTime.toLocal();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Opacity(
                  opacity: gp.active ? 1.0 : 0.5,
                  child: DriverTile(
                    childWidget: ListTile(
                      tileColor: Colors.grey[900],
                      title: Text(gp.gpName,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        gp.circuitName,
                        style: TextStyle(color: Colors.white54),
                      ),
                      trailing: Text(date.day.toString().padLeft(2, "0") +
                          ", " +
                          monthName[date.month]),
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
