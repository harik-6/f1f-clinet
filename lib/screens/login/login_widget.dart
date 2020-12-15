import 'package:f1fantasy/models/user_model.dart';
import 'package:f1fantasy/screens/login/terms_condition.dart';
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
  bool tryAgain = false;
  final AuthService _authService = AuthService();

  void _preAuthPrcess() {
    setState(() {
      isAuthenticating = true;
      tryAgain = false;
    });
  }

  void _postAuthProcess(AppUser user) {
    if (user == null) {
      setState(() {
        isAuthenticating = false;
        tryAgain = true;
      });
      _authService.signOut();
    }
  }

 void _googleSignIn() async {
    _preAuthPrcess();
    AppUser user = await _authService.signInWithGoogle();
    _postAuthProcess(user);
  }

  void _facebookSignIn() async {
    _preAuthPrcess();
    AppUser user = await _authService.signInWithFacebook();
    _postAuthProcess(user);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
                tryAgain
                    ? Padding(
                        padding: EdgeInsets.all(8.0), child: Text("Try again"))
                    : SizedBox.shrink(),
                Column(
                  children: isAuthenticating
                      ? [
                          CircularProgressIndicator(),
                          SizedBox(height: 20.0),
                          Text("Signing in")
                        ]
                      : [
                          Text("Continue with"),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _googleSignIn,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22.0,
                                    backgroundImage: AssetImage(
                                        "assets/images/google-icon.png")),
                              ),
                              SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: _facebookSignIn,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22.0,
                                    backgroundImage: AssetImage(
                                        "assets/images/fb-icon.png")),
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("By signing in,you agree with the",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12.0,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            contentPadding: EdgeInsets.all(8.0),
                                            title: Text(
                                                "Terms & conditions,Privacy Policy"),
                                            content: TermsConditions(),
                                            actions: [
                                              RaisedButton(
                                                  child: Text("I Understand"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  })
                                            ],
                                          ),
                                      barrierDismissible: true);
                                },
                                child: Text(" Terms & Conditions",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12.0,
                                    )),
                              )
                            ],
                          )
                        ],
                ),
                SizedBox(height: 50.0),
              ],
            )),
      ),
    );
  }
}
