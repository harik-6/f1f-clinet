import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/points.dart';
import 'package:f1fantasy/constants/month_constants.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:flutter/material.dart';

class MyLeagues extends StatefulWidget {
  final List<GrandPrix> list;
  MyLeagues(this.list);
  @override
  _MyLeaguesState createState() => _MyLeaguesState();
}

class _MyLeaguesState extends State<MyLeagues> {
  @override
  Widget build(BuildContext context) {
    return widget.list.length == 0
        ? (Center(
            child: Text("You have not participated in any league."),
          ))
        : (Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    GrandPrix league = widget.list[index];
                    DateTime date = league.dateTime.toLocal();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 12.0),
                      child: DriverTile(
                        childWidget: ListTile(
                          tileColor: Colors.grey[900],
                          title: Text(league.gpName,
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                              date.day.toString().padLeft(2, "0") +
                                  ", " +
                                  monthName[date.month],
                              style: TextStyle(color: Colors.white54)),
                          trailing: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:12.0),
                            child: Text((index + 1).toString()+" Pts",style: TextStyle(
                              fontSize: 16.0
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ));
  }
}
