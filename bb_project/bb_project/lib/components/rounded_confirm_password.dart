import 'package:bb_project/components/text_field_container.dart';
import 'package:bb_project/constants.dart';
import 'package:flutter/material.dart';

class RoundedConfirmPasswordField extends StatelessWidget {
  final textContoller;

  const RoundedConfirmPasswordField({Key? key, required this.textContoller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        controller: textContoller,
        decoration: const InputDecoration(
            hintText: "Confirm Password",
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
