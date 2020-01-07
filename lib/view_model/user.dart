import 'package:coeops/models/user.dart';
import 'package:coeops/services/auth_service.dart';
import 'package:coeops/services/dialog_service.dart';
import 'package:coeops/services/locator.dart';
import 'package:coeops/view_model/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

const ERROR_MESSAGE = "😥 Something went wrong. Please try again later!";

class UserViewModel extends BaseViewModel {
  DialogService _dialogService = locator<DialogService>();

  String _message;
  User _userProfile;

  String get message => _message;

  User get userProfile => _userProfile;

  Future<bool> create(Map<String, String> formData) async {
    setStatus(ViewStatus.Loading);
    FirebaseUser user;
    try {
      user = await AuthService().registerWithEmailAndPassword(
          formData['fullname'], formData['email'], formData['password']);
      await _dialogService
          .showAlertDialog("Yay! Your account has been created. Continue!");
    } on PlatformException catch (error) {
      print(error.message);
      _dialogService.showAlertDialog(error.message);
    }
    setStatus(ViewStatus.Ready);

    return user != null;
  }

  // sign in with email and password
  Future<bool> signInWithEmailAndPassword(Map<String, String> formData) async {
    setStatus(ViewStatus.Loading);
    FirebaseUser user;
    try {
      user = await AuthService()
          .signInWithEmailAndPassword(formData['email'], formData['password']);
    } on PlatformException catch (error) {
      print(error.message);
      _dialogService.showAlertDialog(error.message);
    }
    setStatus(ViewStatus.Ready);

    return user != null;
  }
}
