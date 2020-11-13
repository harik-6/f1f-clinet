import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1fantasy/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final CollectionReference userdb =
      FirebaseFirestore.instance.collection('users');

  Future<AppUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount account = await googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      final AuthCredential creds = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      UserCredential usercreds = await auth.signInWithCredential(creds);
      AppUser user = await addUserToFiredb(usercreds);
      return user;
    } on Exception catch (_) {} catch (_) {
      return null;
    }
  }

  Future<AppUser> addUserToFiredb(UserCredential credential) async {
    try {
      User loggedInUser = credential.user;
      AppUser user = new AppUser(
          uid: loggedInUser.uid,
          name: loggedInUser.displayName,
          email: loggedInUser.email,
          photoUrl: loggedInUser.photoURL);
      await userdb.doc(loggedInUser.uid).set(user.modeltoJson());
      return user;
    } catch (error) {
      throw Error();
    }
  }

  bool get isSignedIn {
    User user = auth.currentUser;
    if (user == null) return false;
    // print("Current user");
    // print(user.uid);
    return true;
  }

  void signOut() async {
    await googleSignIn.disconnect();
    await auth.signOut();
  }
}
