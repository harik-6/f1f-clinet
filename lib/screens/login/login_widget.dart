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

  void googleSignIn() async {
    setState(() {
      isAuthenticating = true;
      tryAgain = false;
    });
    AuthService service = AuthService();
    AppUser user = await service.signInWithGoogle();
    if (user == null) {
      setState(() {
        isAuthenticating = false;
        tryAgain = true;
      });
      service.signOut();
    }
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
                  tryAgain
                      ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Try again"))
                      : SizedBox.shrink(),
                  Column(
                    children: isAuthenticating
                        ? [
                            CircularProgressIndicator(),
                            SizedBox(height: 10.0),
                            Text("Signing in")
                          ]
                        : [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                        'assets/images/google-icon.png'),
                                    width: 32.0,
                                    height: 32.0,
                                  ),
                                  Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
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
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              title: Text(
                                                  "Terms & conditions,Privacy Policy"),
                                              content: TermsConditions(),
                                              actions: [
                                                RaisedButton(
                                                    child: Text("I Understand"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
      ),
    );
  }
}
