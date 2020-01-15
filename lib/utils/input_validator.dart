import 'package:email_validator/email_validator.dart';

class InputValidator {
  static String name(value) {
    if (value.isEmpty) {
      return 'Please provide your name!';
    }
    return null;
  }

  static String email(value) {
    if (value.isEmpty) {
      return 'Please provide your email address!';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String password(value) {
    if (value.isEmpty) {
      return 'Please provide your password!';
    }
    if (value.length < 8 || value.length > 20) {
      return 'Password must be between 8 - 20 characters!';
    }
    // if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    //   return 'Sorry, special characters are not allowed!';
    // }
    return null;
  }

  static String title(String value) {
    if (value.isEmpty) {
      return 'C\'mon, give me a headline!';
    }
    return null;
  }
  static String content(String value) {
    if (value.isEmpty) {
      return 'Please provide this field!';
    }
    return null;
  }
}
