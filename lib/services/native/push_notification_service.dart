import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static final PushNotificationService _instance =
      PushNotificationService._internal();
  factory PushNotificationService() {
    return _instance;
  }
  PushNotificationService._internal();

  Future<void> initialize() async {
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print(message.toString());
    }, onLaunch: (Map<String, dynamic> message) async {
      print(message.toString());
    }, onResume: (Map<String, dynamic> message) async {
      print(message.toString());
    });
  }
}
