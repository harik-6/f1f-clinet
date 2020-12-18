import 'package:formulafantasy/constants/app_constants.dart';
import 'package:formulafantasy/constants/styles.dart';
import 'package:formulafantasy/models/user_model.dart';
import 'package:formulafantasy/services/native/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatelessWidget {
  final AppUser user;
  SideDrawer(this.user);

  Future<void> _signOut() async {
    await AuthService().signOut();
  }

  Future<void> _shareApp() async {
    await Share.share(
        'check out the F1Fantasy app, sign to choose your drivers and rule the leaderboard '+AppConstants.platStoreUrl);
  }

  void _rateApp() {
    launch(AppConstants.platStoreUrl);
  }

  void _feedback() {
    launch("mailto:dev.f1fantasy@gmail.com?subject=Report/Issue#");
  }

  void _openInstagram() {
    launch("https://www.instagram.com/_f1fantasy");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40.0),
                  image: DecorationImage(
                      image: NetworkImage(user.photoUrl), fit: BoxFit.cover)),
            ),
            SizedBox(height: 20.0),
            Center(child: Text(user.name.split(" ")[0], style: headerText)),
            SizedBox(height: 10.0),
            GestureDetector(
                onTap: _shareApp,
                child: ListTile(
                  title: Text("Share app"),
                  trailing: Icon(Icons.share, color: Colors.white),
                )),
            GestureDetector(
                onTap: _rateApp,
                child: ListTile(
                  title: Text("Rate app"),
                  trailing: Icon(Icons.star_rate, color: Colors.white),
                )),
            GestureDetector(
                onTap: _feedback,
                child: ListTile(
                  title: Text("Report issue"),
                  trailing: Icon(Icons.mail, color: Colors.white),
                )),
            GestureDetector(
                onTap: _openInstagram,
                child: ListTile(
                  title: Text("Our Instagram"),
                  trailing: Icon(Icons.camera_alt, color: Colors.white),
                )),
            Expanded(child: SizedBox.shrink()),
            GestureDetector(
              onTap: _signOut,
              child: ListTile(
                title: Text("Sign out"),
                trailing: Icon(Icons.exit_to_app, color: Colors.white),
              ),
            ),
            Text(DateTime.now().year.toString() + " \u00a9 F1Fantasy",
                style: TextStyle(color: Colors.white54)),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }
}
