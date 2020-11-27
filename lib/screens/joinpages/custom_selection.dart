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
  final String activeId;
  CustomPosition(
      {Key key, this.drCredits, this.callback, this.roundtype, this.activeId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CustomPosition();
  }
}

class _CustomPosition extends State<CustomPosition> {
  void _setDriverId(String drId) {
    widget.callback(drId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Text(widget.roundtype, style: headerText)),
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
                                widget.activeId == driver.id
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green[600],
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
