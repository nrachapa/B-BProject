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

import '../../../components/rounded_confirm_password.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: size.height * 0.05),
        RoundedInputField(hintText: "Your Email", onChanged: (value) {}),
        FirstName(hintText: "First Name", onChanged: (value) {}),
        LastName(hintText: "Last Name", onChanged: (value) {}),
        EmployeeID(hintText: "Employee ID", onChanged: (value) {}),
        RoundedPasswordField(onChanged: (value) {}),
        RoundedConfirmPasswordField(onChanged: (value) {}),
        RoundedButton(text: "SIGNUP", press: () {}),
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
    ))
    ;
  }
}
