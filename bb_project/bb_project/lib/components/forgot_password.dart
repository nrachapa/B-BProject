import 'package:flutter/material.dart';

import '../constants.dart';

class ForgotPassword extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const ForgotPassword({Key? key, this.login = true, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: const Text(
              "Forgot Password?",
            style: TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
