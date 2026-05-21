import 'package:flutter/material.dart';

class CharacterScreenCardPortalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(18, 0)
      ..lineTo(size.width - 38, 0)
      ..quadraticBezierTo(size.width - 10, 0, size.width - 4, 28)
      ..lineTo(size.width, size.height - 48)
      ..quadraticBezierTo(
        size.width - 2,
        size.height - 18,
        size.width - 30,
        size.height,
      )
      ..lineTo(20, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 20)
      ..lineTo(0, 24)
      ..quadraticBezierTo(0, 3, 18, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
