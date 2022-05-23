import 'package:bb_project/components/text_field_container.dart';
import 'package:bb_project/constants.dart';
import 'package:flutter/material.dart';

class EmployeeID extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final textController;
  const EmployeeID({Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFieldContainer(
      child: TextField(
        controller: textController,
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