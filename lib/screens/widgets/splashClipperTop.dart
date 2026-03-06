import 'package:flutter/material.dart';

class WaveClipTop extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
  var path = Path();

  path.moveTo(0, size.height - 70);

  path.quadraticBezierTo(
    size.width * 3/5,
    size.height + 5,
    size.width * 3/5,
    size.height - 50,
    );
    path.quadraticBezierTo(
      size.width * 3/5,
      size.height - 120,
      size.width,
      size.height - 50
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
}

@override
bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}