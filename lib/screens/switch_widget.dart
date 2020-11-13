import 'package:f1fantasy/screens/home_screen.dart';
import 'package:f1fantasy/screens/login_widget.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final bool hasAlreadySignedIn;
  SwitchWidget(this.hasAlreadySignedIn);
  @override
  Widget build(BuildContext context) {
    if(hasAlreadySignedIn) {
      return AppHome();
    }
    return LoginWidget();
  }
}