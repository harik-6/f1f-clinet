import 'package:f1fantasy/models/user_model.dart';
import 'package:f1fantasy/services/native/auth_service.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidget createState() {
    return _LoginWidget();
  }
}

class _LoginWidget extends State<LoginWidget> {
  bool isAuthenticating = false;

  void googleSignIn() async {
    setState(() {
      isAuthenticating = true;
    });
    AppUser signedUser = await AuthService().signInWithGoogle();
    print(signedUser.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: googleSignIn,
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login-bg.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/fantasy-icon.png'),
                    width: 150.0,
                    height: 150.0,
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: isAuthenticating
                        ? Center(
                            child: Text(
                              "Signing in",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image:
                                    AssetImage('assets/images/google-icon.png'),
                                width: 32.0,
                                height: 32.0,
                              ),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                  ),
                  SizedBox(height: 20.0),
                  Text("Continue without sign in",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  SizedBox(height: 25.0),
                ],
              )),
        ),
      ),
    );
  }
}
