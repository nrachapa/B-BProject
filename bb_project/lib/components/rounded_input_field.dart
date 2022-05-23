import 'package:bb_project/components/text_field_container.dart';
import 'package:bb_project/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final controllerText;
  const RoundedInputField({Key? key,
    required this.hintText,
    this.icon = Icons.person,
    this.controllerText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFieldContainer(
      child: TextField(
        controller: controllerText,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}