import 'package:aulerta_final/repositories/medicine/createMedicine.dart';
import 'package:aulerta_final/repositories/medicine/deleteMedicine.dart';
import 'package:flutter/material.dart';

class DeleteMedicineController extends ChangeNotifier {
  DeleteMedicineAPI repository = DeleteMedicineAPI();

  bool response = false;

  Future deleteMedicine(String id, String token) async {
    response = await repository.deleteMedicine(id, token);

    notifyListeners();
  }
}
