import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:f1fantasy/constants/app_enums.dart';

class ConnectivityServie {
  static final ConnectivityServie _instance = ConnectivityServie._internal();
  final Connectivity _connectivity = Connectivity();
  INTERNET_STATUS deviceStatus = INTERNET_STATUS.offline;
  StreamController<INTERNET_STATUS> _connectionChangeController =
      new StreamController<INTERNET_STATUS>.broadcast();

  Stream get onConnectionChange => _connectionChangeController.stream;

  factory ConnectivityServie() {
    return _instance;
  }

  ConnectivityServie._internal();

  Future<void> initiliaze() async {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.none:
        deviceStatus = INTERNET_STATUS.offline;
        _connectionChangeController.add(deviceStatus);
        return;
      default:
        await _checkInternetConnection();
        return;
    }
  }

  void updateDeviceOffline() {
    _connectionChangeController.add(INTERNET_STATUS.offline);
  }

  void initCheckConnection() {
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        deviceStatus = INTERNET_STATUS.online;
      } else {
        deviceStatus = INTERNET_STATUS.offline;
      }
    } on SocketException catch (_) {
      deviceStatus = INTERNET_STATUS.offline;
    }
    _connectionChangeController.add(deviceStatus);
  }

  void dispose() {
    _connectionChangeController.close();
  }
}
