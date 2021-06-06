import 'package:flutter/material.dart';

class LoginBloc extends ChangeNotifier {
  bool _isCompleted;

  get isCompleted => _isCompleted;

  authData(bool isCompleted) {
    _isCompleted = isCompleted;
  }
}
