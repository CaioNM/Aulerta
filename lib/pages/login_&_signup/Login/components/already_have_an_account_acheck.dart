import 'package:aulerta_final/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    super.key, 
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Ainda não tem uma conta? " : "Já tem uma conta? ",
          style: GoogleFonts.inter(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Crie uma!" : "Entre!",
            style: GoogleFonts.inter(
                color: kPrimaryColor, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}