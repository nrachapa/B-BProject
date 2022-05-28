import 'dart:io';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget(
      {Key? key, required this.imagePath, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .colorScheme
        .primary;

    return Center(
      child: Stack(
        children: [
          Positioned(
              child: buildImage()
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          )
        ],
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      all: 3,
      color: Colors.white,
      child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          )
      )
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
}) => ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    ),
  );

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 150,
            height: 150,
            child: InkWell(onTap: onClicked)),
      ),
    );
  }
}
