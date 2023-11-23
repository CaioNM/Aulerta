import 'dart:convert';
import 'dart:io';
import 'package:aulerta_final/models/medicines/showMedicine_model.dart';
import 'package:aulerta_final/utils/url.dart';
import 'package:http/http.dart' as http;

class ShowMedicineAPI {
  showMedicine(String idPet, String token) async {
    showMedicine_model ? medicine_model = showMedicine_model();
    List<Medicines>? medicines = [];
    var url = Uri.parse('${VariaveisGlobais.baseUrl}/medicines/${idPet}');
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> retorno = json.decode(utf8.decode(response.bodyBytes));

      medicine_model = showMedicine_model.fromJson(retorno);

      print(medicine_model.medicines);

      for(int i = 0 ; i < medicine_model.medicines!.length ; i++  ){
        medicines.add(medicine_model.medicines![i]);
      };

      return medicines;
    } else {
      throw Exception('Falha ao carregar os medicamentos');
    }
  }
}
