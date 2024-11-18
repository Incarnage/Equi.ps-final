import 'package:flutter/material.dart';

class ECustomeCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final fCurve = Offset(0, size.height - 20);
    final lCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(fCurve.dx, fCurve.dy, lCurve.dx, lCurve.dy);

    final sfCurve = Offset(0, size.height - 20);
    final slCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(sfCurve.dx, sfCurve.dy, slCurve.dx, slCurve.dy);

    final tfCurve = Offset(size.width, size.height - 20);
    final tlCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(tfCurve.dx, tfCurve.dy, tlCurve.dx, tlCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
