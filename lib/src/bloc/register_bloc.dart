import 'package:flutter/material.dart';

class RegisterBloc extends ChangeNotifier {
  String _email = '';

  get email => _email;

  authData(String email) {
    _email = email;
    notifyListeners();
  }
}
