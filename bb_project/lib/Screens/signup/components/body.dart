import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:bb_project/Screens/signup/components/background.dart';
import 'package:bb_project/components/Employee_id.dart';
import 'package:bb_project/components/existing_account.dart';
import 'package:bb_project/components/first_name.dart';
import 'package:bb_project/components/last_name.dart';
import 'package:bb_project/components/rounded_button.dart';
import 'package:bb_project/components/rounded_input_field.dart';
import 'package:bb_project/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../components/rounded_confirm_password.dart';
import '../../Message.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final controllerNewEmail = TextEditingController();
  final controllerNewPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  final controllerNewFirstName = TextEditingController();
  final controllerNewLastName = TextEditingController();
  final controllerNewEmployeeID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void doUserRegistration() async {
      if (controllerNewPassword.text
              .trim()
              .compareTo(controllerConfirmPassword.text.trim()) !=
          0) {
        Message.showError(context: context, message: "Passwords do not match!");
        return;
      }

      final email = controllerNewEmail.text.trim();
      final password = controllerNewPassword.text.trim();
      final username = controllerNewFirstName.text.trim();

      final user = ParseUser.createUser(username, password, email);

      var response = await user.signUp();

      if (response.success) {
        Message.showSuccess(
            context: context,
            message:
                'User was successfully created! Please verify your email before Login',
            onPressed: () async {
              Navigator.pop(context);
            });
      } else {
        Message.showError(context: context, message: response.error!.message);
      }
    }

    Size size = MediaQuery.of(context).size;
    return Background(

        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: size.height * 0.05),
        RoundedInputField(
          hintText: "Your Email",
          controllerText: controllerNewEmail,
        ),
        FirstName(
          hintText: "First Name",
          textController: controllerNewFirstName,
        ),
        LastName(hintText: "Last Name", textController: controllerNewLastName),
        EmployeeID(
          hintText: "Employee ID",
          textController: controllerNewEmployeeID,
        ),
        RoundedPasswordField(
          controllerText: controllerNewPassword,
        ),
        RoundedConfirmPasswordField(
          textContoller: controllerConfirmPassword,
        ),
        RoundedButton(text: "SIGNUP", press: () => doUserRegistration()),
        existingAccount(
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          login: false,
        )
      ],
    ));
  }
}
