import 'package:f1fantasy/components/no_internet.dart';
import 'package:f1fantasy/components/preloader.dart';
import 'package:f1fantasy/constants/app_enums.dart';
import 'package:f1fantasy/screens/home/home_screen.dart';
import 'package:f1fantasy/screens/login/login_widget.dart';
import 'package:f1fantasy/services/native/connection_service.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final bool hasAlreadySignedIn;
  SwitchWidget(this.hasAlreadySignedIn) {
    ConnectivityServie().initCheckConnection();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<INTERNET_STATUS>(
        stream: ConnectivityServie().onConnectionChange,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return PreLoader();
            case ConnectionState.active:
              switch (snapshot.data) {
                case INTERNET_STATUS.online:
                  if (hasAlreadySignedIn) {
                    return AppHome();
                  }
                  return LoginWidget();
                case INTERNET_STATUS.offline:
                  return NoInternet();
                  return null;
              }
              return null;
            default:
              return null;
          }
        });
  }
}
