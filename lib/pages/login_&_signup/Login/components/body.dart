import 'package:aulerta_final/controller/login/login_controller.dart';
import 'package:aulerta_final/models/users/login_model.dart';
import 'package:aulerta_final/pages/home.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/already_have_an_account_acheck.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/background.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/input_field.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/components/password_field.dart';
import 'package:aulerta_final/pages/login_&_signup/SignUp/signup.dart';
import 'package:aulerta_final/pages/pills/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

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
    return Consumer<LoginController>(
        builder: (context, loginController, child) {
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
                    await loginController.getUserData(
                        _textFieldValueLogin, _textFieldValuePassword);
                    login_model? loginModel = loginController.loginModel;
                    if (loginModel != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      Get.snackbar("Erro",
                          "E-mail e/ou Senha inválidos. Tente novamente.",
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
                      : const Text("LOGIN"),
                ),
              ),
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
    });
  }
}
