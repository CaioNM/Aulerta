import 'package:aulerta_final/pages/onboarding_&_home/intro_screen.dart';
import 'package:aulerta_final/pages/pills/pages/cadastro/new_entry_bloc.dart';
import 'package:aulerta_final/pages/task/db/db.dart';
import 'package:aulerta_final/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MultiProvider(
      providers: providers,
      child: const MyApp(),
    ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  NewEntryBloc? newEntryBloc;

  @override
  void initState() {
    newEntryBloc = NewEntryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NewEntryBloc>.value(
      value: newEntryBloc!,
      child: Sizer(builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Aulerta',
          theme: ThemeData.light().copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.light().textTheme,
            ),
          ),
          home: const IntroScreen(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
