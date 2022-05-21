import 'package:bb_project/components/text_field_container.dart';
import 'package:bb_project/constants.dart';
import 'package:flutter/material.dart';

class RoundedConfirmPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedConfirmPasswordField({Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
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
