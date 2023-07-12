import 'package:bb_project/Screens/admin_screen_1/admin_screen_1.dart';
import 'package:bb_project/Screens/project_screen_1/project_screen_1.dart';
import 'package:bb_project/Screens/login/components/background.dart';
import 'package:bb_project/Screens/signup/signup_screen.dart';
import 'package:bb_project/components/forgot_password.dart';
import 'package:bb_project/components/rounded_button.dart';
import 'package:bb_project/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../Message.dart';

import '../../../components/existing_account.dart';
import '../../../components/rounded_password_field.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    void doUserLogin() async {
      final username = controllerUsername.text.trim();
      final password = controllerPassword.text.trim();
      final user = ParseUser(username, password, null);
      var response = await user.login();
      await user.fetch();
      final ADMIN = user.get('admin') ?? false;
      if (response.success & ADMIN) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminScreen()),
          (Route<dynamic> route) => false,
        );
      } else if (response.success & !ADMIN) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ProjectScreen1()),
          (Route<dynamic> route) => false,
        );
      } else {
        Message.showError(context: context, message: response.error!.message);
      }
    }

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
            controllerText: controllerUsername,
          ),
          SizedBox(height: size.height * 0.0),
          RoundedPasswordField(
            controllerText: controllerPassword,
          ),
          SizedBox(height: size.height * 0.01),
          RoundedButton(text: "LOGIN", press: () => doUserLogin()),
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
