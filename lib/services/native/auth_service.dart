import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1fantasy/models/user_model.dart';
import 'package:f1fantasy/services/native/pref_service.dart';
import 'package:f1fantasy/services/native/push_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();
  final CollectionReference userdb =
      FirebaseFirestore.instance.collection('users');

  AppUser _convertUser(User loggedInUser) {
    return new AppUser(
        uid: loggedInUser.uid,
        name: loggedInUser.displayName,
        email: loggedInUser.email,
        photoUrl: loggedInUser.photoURL);
  }

  Future<AppUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount account =
          await googleSignIn.signIn().catchError((onError) {
        return false;
      });
      if (account != null) {
        final GoogleSignInAuthentication authentication =
            await account.authentication;
        final AuthCredential creds = GoogleAuthProvider.credential(
            idToken: authentication.idToken,
            accessToken: authentication.accessToken);
        return addUserToFiredb(creds);
      }
      return null;
    } on Exception catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<AppUser> signInWithFacebook() async {
    try {
      FacebookLoginResult result = await facebookSignIn.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]);
      if (result != null && result.status == FacebookLoginStatus.Success) {
        final AuthCredential creds =
            // ignore: deprecated_member_use
            FacebookAuthProvider.getCredential(result.accessToken.token);
        return addUserToFiredb(creds);
      }
      return null;
    } on Exception catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  AppUser getUser() {
    return _convertUser(auth.currentUser);
  }

  Future<AppUser> addUserToFiredb(AuthCredential creds) async {
    try {
      UserCredential usercreds = await auth.signInWithCredential(creds);
      User loggedInUser = usercreds.user;
      String notifToken = await PushNotificationService().token;
      Map<String, String> userToStore = {
        "uid": loggedInUser.uid,
        "name": loggedInUser.displayName,
        "email": loggedInUser.email,
        "photoUrl": loggedInUser.photoURL,
        "pushToken": notifToken
      };
      await userdb.doc(loggedInUser.uid).set(userToStore);
      return _convertUser(loggedInUser);
    } catch (error) {
      return null;
    }
  }

  bool get isSignedIn {
    User user = auth.currentUser;
    if (user == null) return false;
    return true;
  }

  Future<void> signOut() async {
    List<UserInfo> user = auth.currentUser.providerData;
    if (user.length > 0) {
      String provider = user[0].providerId;
      if (provider == "facebook.com") {
        await facebookSignIn.logOut();
      }
      if (provider == "google.com") {
        await googleSignIn.disconnect();
      }
    }
    await new PrefService().clearDate();
    await auth.signOut();
  }
}
