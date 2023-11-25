import 'package:aulerta_final/pages/pills/constants.dart';
import 'package:aulerta_final/pages/pills/pages/cadastro/new_entry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Pills extends StatefulWidget {
  const Pills({super.key});

  @override
  State<Pills> createState() => _PillsState();
}

class _PillsState extends State<Pills> {
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
        return MaterialApp(
          title: 'Pill Reminder',
          theme: ThemeData.dark().copyWith(
            primaryColor: pkPrimaryColor,
            scaffoldBackgroundColor: pkScaffordColor,
            appBarTheme: AppBarTheme(
              toolbarHeight: 7.h,
              backgroundColor: pkScaffordColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: pkSecondaryColor,
                size: 20.sp,
              ),
              titleTextStyle: GoogleFonts.mulish(
                color: pkTextColor,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontSize: 16.sp,
              ),
            ),
            textTheme: TextTheme(
              displaySmall: TextStyle(
                fontSize: 28.sp,
                color: pkSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
              headlineMedium: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: pkTextColor,
              ),
              headlineSmall: TextStyle(
                fontSize: 1,
                fontWeight: FontWeight.w900,
                color: pkTextColor,
              ),
              titleLarge: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: pkTextColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
              titleSmall:
                  GoogleFonts.poppins(fontSize: 12.sp, color: pkTextLightColor),
              bodySmall: GoogleFonts.poppins(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                  color: pkTextLightColor),
              labelMedium: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: pkTextColor,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: pkTextLightColor,
                  width: 0.7,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: pkTextLightColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: pkTextLightColor,
                ),
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: pkScaffordColor,
              hourMinuteColor: pkTextColor,
              hourMinuteTextColor: pkScaffordColor,
              dayPeriodColor: pkTextColor,
              dayPeriodTextColor: pkScaffordColor,
              dialBackgroundColor: pkTextColor,
              dialHandColor: pkPrimaryColor,
              dialTextColor: pkScaffordColor,
              entryModeIconColor: pkOtherColor,
              dayPeriodTextStyle: GoogleFonts.aBeeZee(
                fontSize: 8.sp,
              ),
            ),
          ),
        );
      }),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}