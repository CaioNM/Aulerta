import 'package:aulerta_final/models/medicines/showMedicine_model.dart';
import 'package:aulerta_final/repositories/medicine/showMedicine.dart';
import 'package:flutter/material.dart';

class ShowMedicineController extends ChangeNotifier {
  //showMedicine_model? showMedicineModel;
  ShowMedicineAPI repository = ShowMedicineAPI();

  // List<showMedicine_model> medicines = [];

  List<Medicines>? medicines = [];

  Future showMedicine(String idPet, String token) async {
    medicines = [];
    medicines = await repository.showMedicine(idPet, token);

    notifyListeners();
  }
}
