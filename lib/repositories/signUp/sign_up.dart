import 'dart:convert';
import 'dart:io';
import 'package:aulerta_final/utils/url.dart';
import 'package:http/http.dart' as http;
 

class SignUpAPI {
  signUp(String email, String password) async {
    var url = Uri.parse('${VariaveisGlobais.baseUrl}/users');
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map params = {
      "name": "Tester",
      'email': email,
      'password': password,
      "ct_emergency": "0000-0000"
    };

    var body = json.encode(params);
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {

      return true;
    } else {
      return false;
    }
  }
}