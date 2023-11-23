import 'package:aulerta_final/controller/Medicine/createMedicineController.dart';
import 'package:aulerta_final/controller/Medicine/deleteMedicineController.dart';
import 'package:aulerta_final/controller/Medicine/showMedicineController.dart';
import 'package:aulerta_final/controller/login/login_controller.dart';
import 'package:aulerta_final/controller/signUp/signUp_controller.dart';
import 'package:provider/provider.dart';

final providers = [
  ChangeNotifierProvider<LoginController>(
    create: (context) => LoginController(),
  ),

  ChangeNotifierProvider<SignUpController>(
    create: (context) => SignUpController(),
  ),

  ChangeNotifierProvider<CreateMedicineController>(
    create: (context) => CreateMedicineController(),
  ),

  ChangeNotifierProvider<ShowMedicineController>(
    create: (context) => ShowMedicineController(),
  ),

  ChangeNotifierProvider<DeleteMedicineController>(
    create: (context) => DeleteMedicineController(),
  ),
];