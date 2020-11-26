import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/driver_credit_model.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/components/driver_names.dart';
import 'package:f1fantasy/components/driver_tile.dart';
import 'package:f1fantasy/components/team_indicator.dart';
import 'package:f1fantasy/models/driver_model.dart';

class CustomPosition extends StatefulWidget {
  final Function callback;
  final List<DriverCredit> drCredits;
  final String roundtype;
  CustomPosition({Key key, this.drCredits, this.callback, this.roundtype})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CustomPosition();
  }
}

class _CustomPosition extends State<CustomPosition> {
  String _selectedDriverId = "-1";

  void _setDriverId(String drId) {
    widget.callback(drId);
    setState(() {
      _selectedDriverId = drId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 20.0, right: 90.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(widget.roundtype, style: headerText)],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount: widget.drCredits.length,
                  itemBuilder: (context, index) {
                    Driver driver = widget.drCredits[index].driver;
                    return GestureDetector(
                      onTap: () => _setDriverId(driver.id),
                      child: Container(
                        key: Key(driver.firstName),
                        width: double.infinity,
                        height: 80.0,
                        child: ListTile(
                          title: DriverTile(
                            childWidget: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                TeamIndicator(driver.team),
                                SizedBox(width: 8.0),
                                DriverNames(
                                    driver.firstName, driver.secondName),
                                Expanded(child: SizedBox.shrink()),
                                _selectedDriverId == driver.id
                                    ? Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.circle,
                                        color: Colors.white,
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
              SizedBox(height: 20.0)
            ],
          ),
        ));
  }
}
