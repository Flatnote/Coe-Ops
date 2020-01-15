import 'package:coeops/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences prefs;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      prefs = await SharedPreferences.getInstance();
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // Check is already sign up
      final QuerySnapshot firestoreResult = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = firestoreResult.documents;

      // Write data to local
      await prefs.setString('id', documents[0]['id']);
      await prefs.setString('nickname', documents[0]['nickname']);
      await prefs.setString('photoUrl', documents[0]['photoUrl']);
      await prefs.setString('aboutMe', documents[0]['aboutMe']);

      _userFromFirebaseUser(user);
      return user;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  // sign in with google
  Future signInWithGoogle(AuthCredential credential) async {
    try {
      prefs = await SharedPreferences.getInstance();
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      // Check is already sign up
      final QuerySnapshot firestoreResult = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = firestoreResult.documents;

      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(user.uid).setData({
          'nickname': user.displayName,
          'photoUrl': user.photoUrl,
          'id': user.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // Write data to local
        await prefs.setString('id', user.uid);
        await prefs.setString('nickname', user.displayName);
        await prefs.setString('photoUrl', user.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }

      _userFromFirebaseUser(user);
      return user;
    } catch (error) {
      throw error;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String fullname, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // Update data to server if new user
      Firestore.instance.collection('users').document(user.uid).setData({
        'nickname': fullname,
        'photoUrl': null,
        'id': user.uid,
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        'chattingWith': null
      });
      await prefs.setString('id', user.uid);
      await prefs.setString('nickname', fullname);
      await prefs.setString('photoUrl', user.photoUrl);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      bool isSigned = await googleSignIn.isSignedIn();

      if (isSigned) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
        await _auth.signOut();
      } else {
        await _auth.signOut();
      }

      return true;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
