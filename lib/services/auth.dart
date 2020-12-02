import 'package:ready_set_cook/models/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart' as fire;

class AuthService {
  final fire.FirebaseAuth _auth = fire.FirebaseAuth.instance;

  // create user obj based on firebase user
  u.User _userFromFirebaseUser(fire.User user) {
    return user != null ? u.User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<u.User> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  String getCurrentUserEmail() {
    return _auth.currentUser.email;
  }

  String getCurrentUserFirstName() {
    return _auth.currentUser.displayName;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      fire.UserCredential result = await _auth.signInAnonymously();
      fire.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      fire.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fire.User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      fire.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fire.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // send password reset email
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
