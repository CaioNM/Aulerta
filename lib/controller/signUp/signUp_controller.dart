import 'package:aulerta_final/repositories/signUp/sign_up.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  SignUpAPI repository = SignUpAPI();

  bool response = false;

  Future createUser(String email, String password) async {
    response = await repository.signUp(email, password);

    notifyListeners();
  }
}
