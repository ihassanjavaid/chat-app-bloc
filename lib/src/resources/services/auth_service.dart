import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:the_chat_app/src/resources/services/firestore_service.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final _gSignIn = GoogleSignIn();

  User getCurrentUser() => _auth.currentUser;

  Future<void> checkInternConnection() async {
    final ConnectivityResult connectivityStatus =
        await (Connectivity().checkConnectivity());

    if (connectivityStatus == ConnectivityResult.none)
      throw 'No internet connection';
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> loginUserWithEmailAndPassword(
      {String email, String password}) async {
    await checkInternConnection();
    // Use the email and password to sign-in the user
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      throw 'Invalid username or password';
    }
  }

  Future<void> registerUser({String email, String password}) async {
    await checkInternConnection();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
      throw 'User already exists';
    }
  }

  Future<void> signInWithG() async {
    await checkInternConnection();
    try {
      GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // changed from AuthResult
        UserCredential authResult =
            await _auth.signInWithCredential(credential);
        // changes from FirebaseUser
        User user = await _auth.currentUser;
      }
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

/*Future<void> updateUserInfo({
    String displayName = '',
    String photoURL = '',
  }) async {
    final userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = displayName;
    userUpdateInfo.photoUrl = photoURL;

    await checkInternConnection();

    try {
      final currentUser = await _auth.currentUser();
      currentUser.updateProfile(userUpdateInfo);
    } catch (e) {
      print(e);
      throw e;
    }
  }*/

}
