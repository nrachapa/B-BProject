import 'package:bb_project/Screens/login/components/background.dart';
import 'package:bb_project/Screens/signup/signup_screen.dart';
import 'package:bb_project/components/forgot_password.dart';
import 'package:bb_project/components/rounded_button.dart';
import 'package:bb_project/components/rounded_input_field.dart';
import 'package:flutter/material.dart';

import '../../../components/existing_account.dart';
import '../../../components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.0),
          Image.asset(
            "assets/images/logo.png",
            height: size.height * 0.20,
          ),
          SizedBox(height: size.height * 0.0),
          RoundedInputField(
            hintText: "Username",
            onChanged: (value) {},
          ),
          SizedBox(height: size.height * 0.0),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          SizedBox(height: size.height * 0.01),
          RoundedButton(text: "LOGIN", press: () {}),
          SizedBox(height: size.height * 0.02),
          existingAccount(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
            login: true,
          ),
          SizedBox(height: size.height * 0.02),
          ForgotPassword(press: () {})
        ],
      ),
    );
  }
}
