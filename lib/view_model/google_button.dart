import 'package:coeops/models/user.dart';
import 'package:coeops/services/auth_service.dart';
import 'package:coeops/services/dialog_service.dart';
import 'package:coeops/services/locator.dart';
import 'package:coeops/view_model/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

const ERROR_MESSAGE = "😥 Something went wrong. Please try again later!";

class GoogleButtonViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();

  String _message;
  User _userProfile;

  String get message => _message;

  User get userProfile => _userProfile;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  // sign in with google
  Future<bool> signInWithGoogle(Map<String, String> formData) async {
    setStatus(ViewStatus.Loading);
    FirebaseUser user;
    try {
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = await AuthService().signInWithGoogle(credential);
    } on PlatformException catch (error) {
      print(error.message);
      _dialogService.showAlertDialog(error.message);
    }
    setStatus(ViewStatus.Ready);

    return user != null;
  }
}
