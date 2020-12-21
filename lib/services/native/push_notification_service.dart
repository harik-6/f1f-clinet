import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static final PushNotificationService _instance =
      PushNotificationService._internal();
  factory PushNotificationService() {
    return _instance;
  }
  PushNotificationService._internal();

  get token async {
    String token = await firebaseMessaging.getToken();
    return token;
  }
}
