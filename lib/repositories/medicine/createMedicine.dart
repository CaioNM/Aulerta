import 'dart:convert';
import 'dart:io';
import 'package:aulerta_final/utils/url.dart';
import 'package:http/http.dart' as http;
 

class CreateMedicineAPI {
  createMedicine(String name, String dose, String frequency, String? type, String idPet, String token) async {
    var url = Uri.parse('${VariaveisGlobais.baseUrl}/medicines/${idPet}');
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    };
    Map params ={
      "name": name, 
      "dose": dose, 
      "frequency": frequency,  
      "type": type
    };

    var body = json.encode(params);
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {

      return true;
    } else {
      return false;
    }
  }
}