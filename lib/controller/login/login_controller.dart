import 'package:aulerta_final/models/users/login_model.dart';
import 'package:aulerta_final/repositories/login/login_api.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  login_model? loginModel;
  LoginApi repository = LoginApi();

  String? token;

  Future getUserData(String login, String senha) async {
    loginModel = await repository.login(login, senha);

    if (loginModel != null) {
      token = loginModel!.token;
    } else {
      token = null;
    }

    notifyListeners();
  }
}
