import 'package:bb_project/constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({Key? key, required this.text, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        onPrimary: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20)
      ),
      onPressed: onClicked,
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }
}
