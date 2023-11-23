import 'package:aulerta_final/controller/Medicine/showMedicineController.dart';
import 'package:aulerta_final/controller/login/login_controller.dart';
import 'package:aulerta_final/models/users/login_model.dart';
import 'package:aulerta_final/pages/home.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/already_have_an_account_acheck.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/background.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/input_field.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/password_field.dart';
import 'package:aulerta_final/pages/login_&_signup/SignUp/signup.dart';
import 'package:aulerta_final/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _textFieldValueLogin = '';

  String _textFieldValuePassword = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LoginController>(
      builder: (context, loginController,child) {
        return Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  )),
                ),
                //SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.40,
                ),
                //SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Seu Email",
                  onChanged: (value) {
                    setState(() {
                      _textFieldValueLogin = value;
                    });
                  },
                ),
                RoundedPassword(
                  onChanged: (value) {
                    setState(() {
                      _textFieldValuePassword = value;
                    });
                  },
                ),
                RoundedButton(
                    text: "LOGIN",
                    press: () async{
                      await loginController.getUserData(_textFieldValueLogin, _textFieldValuePassword);
                      login_model? loginModel = loginController.loginModel; 
                      if(loginModel != null) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false);
                      }
                    }),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpPage();
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
