import 'package:f1fantasy/constants/styles.dart';
import 'package:f1fantasy/models/user_model.dart';
import 'package:f1fantasy/services/native/auth_service.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final AppUser user;
  SideDrawer(this.user);
  Future<void> _signOut() async {
    await AuthService().signOut();
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
            ListTile(
              title: Text("Share app"),
              trailing: Icon(Icons.share, color: Colors.white),
            ),
            ListTile(
              title: Text("Rate app"),
              trailing: Icon(Icons.star_rate, color: Colors.white),
            ),
            ListTile(
              title: Text("Feedback"),
              trailing: Icon(Icons.mail, color: Colors.white),
            ),
            Expanded(child: SizedBox.shrink()),
            GestureDetector(
              onTap: _signOut,
              child: ListTile(
                title: Text("Sign out"),
                trailing: Icon(Icons.logout, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
