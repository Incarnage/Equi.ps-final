import 'package:flutter/material.dart';

class ShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 5,
      spreadRadius: 1,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
