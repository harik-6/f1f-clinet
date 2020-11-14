import 'package:f1fantasy/components/team_icon.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/team_indicator.dart';
import 'package:f1fantasy/models/driver_model.dart';

class MyDrivers extends StatelessWidget {
  final List<Driver> drivers;
  MyDrivers({this.drivers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Drivers"),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      Driver driver = drivers[index];
                      return ListTile(
                        title: DriverTile(
                          childWidget: Row(
                            children: <Widget>[
                              SizedBox(width: 10.0),
                              TeamIndicator(driver.team),
                              SizedBox(width: 8.0),
                              DriverNames(
                                  driver.firstName, driver.secondName),
                              Expanded(child:SizedBox.shrink()),
                              TeamIcon(driver.team, 8.0)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
