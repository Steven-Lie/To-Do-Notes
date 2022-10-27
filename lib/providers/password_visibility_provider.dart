import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  changeObscureStatus() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
