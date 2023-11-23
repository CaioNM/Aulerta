import 'dart:convert';
import 'dart:io';
import 'package:aulerta_final/models/users/login_model.dart';
import 'package:aulerta_final/utils/url.dart';
import 'package:http/http.dart' as http;
 

class LoginApi {
  login(String email, String password) async {
    var url = Uri.parse('${VariaveisGlobais.baseUrl}/session');
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map params = {
      'email': email,
      'password': password,
    };

    var body = json.encode(params);
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> retorno = json.decode(response.body);
      login_model loginModel = login_model();
      loginModel.user = User.fromJson(retorno['user']);
      loginModel.token = retorno['token'];

      return loginModel;
    } else {
      return null;
    }
  }
}