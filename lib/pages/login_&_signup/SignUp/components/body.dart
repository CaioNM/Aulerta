import 'package:aulerta_final/controller/signUp/signUp_controller.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/already_have_an_account_acheck.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/background.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/input_field.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/password_field.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/login.dart';
import 'package:aulerta_final/pages/login_&_signup/SignUp/components/or_divider.dart';
import 'package:aulerta_final/pages/login_&_signup/SignUp/components/social_icon.dart';
import 'package:aulerta_final/pages/pills/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final Widget child;
  const Body({super.key, required this.child});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _textFieldValueLogin = '';

  String _textFieldValuePassword = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SignUpController>(
        builder: (context, signUpController, child) {
      return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "CADASTRE-SE",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Insira seu Email",
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 0.8 * MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: pkPrimaryColor,
                    minimumSize:
                        Size(0.8 * MediaQuery.of(context).size.width, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ), // Use a cor desejada
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await signUpController.createUser(
                        _textFieldValueLogin, _textFieldValuePassword);
                    bool result = signUpController.response;
                    print(result);
                    if (result != false) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (Route<dynamic> route) => false);
                    } else {
                      Get.snackbar("Erro",
                          "Erro ao realizar o cadastro. Por favor, tente novamente mais tarde",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          icon: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.white,
                          ));
                    }
                  },
                  child: isLoading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24 * 0.9,
                              height: 24 * 0.9,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : const Text("CADASTRE-SE"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ),
                  );
                },
              ),
              const OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
