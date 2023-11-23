import 'package:aulerta_final/repositories/medicine/createMedicine.dart';
import 'package:flutter/material.dart';

class CreateMedicineController extends ChangeNotifier {
  CreateMedicineAPI repository = CreateMedicineAPI();

  bool response = false;

  Future createMedicine(String name, String dose, String frequency, String? type, String idPet, String token) async {
    response = await repository.createMedicine(name, dose, frequency, type, idPet, token);

    notifyListeners();
  }
}
