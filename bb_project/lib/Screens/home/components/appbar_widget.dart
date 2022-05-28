import 'package:bb_project/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar (BuildContext context) {
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: const BackButton(),
    backgroundColor: kPrimaryColor,
    elevation: 0,
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(icon))
    ],
  );
}