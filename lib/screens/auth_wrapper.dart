import 'package:formulafantasy/components/preloader.dart';
import 'package:formulafantasy/screens/switch_widget.dart';
import 'package:formulafantasy/services/native/auth_service.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return PreLoader();
        } else {
          return SwitchWidget(AuthService().isSignedIn);
        }
      },
    );
  }
}
