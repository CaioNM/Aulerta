import 'dart:convert';
import 'dart:io';
import 'package:aulerta_final/utils/url.dart';
import 'package:http/http.dart' as http;
 

class DeleteMedicineAPI {
  deleteMedicine(String id, String token) async {
    var url = Uri.parse('${VariaveisGlobais.baseUrl}/medicines/${id}');
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer " + token,

    };
    
    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}