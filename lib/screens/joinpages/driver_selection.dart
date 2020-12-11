import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/driver_credit_model.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/team_indicator.dart';
import 'package:f1fantasy/models/driver_model.dart';

class DriverSelection extends StatefulWidget {
  final Function callback;
  final List<DriverCredit> drCredits;
  DriverSelection({Key key, this.drCredits, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DriverSelection();
  }
}

class _DriverSelection extends State<DriverSelection> {
  List<DriverCredit> drivers = [];
  double totalCredits = 10.0;

  void addToList(int index) {
    List<DriverCredit> present = drivers;
    present[index].isSelected = true;
    double credits = totalCredits - present[index].creditPoints;
    setState(() {
      drivers = present;
      totalCredits = credits;
    });
    widget.callback(present);
  }

  void removeFromList(int index) {
    List<DriverCredit> present = drivers;
    present[index].isSelected = false;
    double credits = totalCredits + present[index].creditPoints;
    setState(() {
      drivers = present;
      totalCredits = credits;
    });
    widget.callback(present);
  }

  bool isActive(DriverCredit selection) {
    return (selection.isSelected) || (selection.creditPoints <= totalCredits);
  }

  @override
  void initState() {
    setState(() {
      drivers = widget.drCredits;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(child: Text("Choose drivers", style: headerText)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Total credits available"),
                SizedBox(width: 50.0),
                Text(totalCredits.toString(), style: headerText)
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  DriverCredit dr = drivers[index];
                  Driver driver = dr.driver;
                  bool active = isActive(dr);
                  return Container(
                    key: Key(driver.firstName),
                    width: double.infinity,
                    height: 80.0,
                    child: Opacity(
                      opacity: active ? 1.0 : 0.5,
                      child: ListTile(
                        title: DriverTile(
                          childWidget: Row(
                            children: <Widget>[
                              SizedBox(width: 10.0),
                              TeamIndicator(driver.team),
                              SizedBox(width: 8.0),
                              DriverNames(driver.firstName, driver.secondName),
                              Expanded(child: SizedBox.shrink()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(dr.creditPoints.toString(),
                                    style: TextStyle(color: Colors.white)),
                              ),
                              IgnorePointer(
                                ignoring: !active,
                                child: dr.isSelected
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.horizontal_rule_outlined,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          removeFromList(index);
                                        },
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          addToList(index);
                                        },
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
          ],
        ));
  }
}
