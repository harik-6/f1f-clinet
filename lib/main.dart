import 'package:f1fantasy/screens/auth_wrapper.dart';
import 'package:f1fantasy/services/native/connection_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:f1fantasy/constants/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ConnectivityServie().initiliaze();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'f1fantasy',
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(bodyText2: textWhite, bodyText1: textWhite)),
      home: AuthWrapper(),
    );
  }
}
