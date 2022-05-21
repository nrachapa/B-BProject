import 'package:flutter/material.dart';

import '../constants.dart';

class existingAccount extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const existingAccount({Key? key, this.login = true, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Don't have an account? Sign Up" : "Already have an account?",
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
