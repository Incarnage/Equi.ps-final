import 'package:flutter/material.dart';

class EColors {
  EColors._();

  //App color
  static const Color primary = Colors.blue;
  static const Color secondary = Color.fromARGB(255, 191, 255, 15);
  static const Color accent = Color.fromARGB(255, 125, 170, 207);

  //Text color

  static const Color textprimary = Color.fromARGB(255, 0, 0, 0);
  static const Color textsecondary = Color.fromARGB(255, 102, 101, 101);
  static const Color textwhite = Color.fromARGB(255, 255, 255, 255);

  //bg color

  static const Color light = Color.fromARGB(255, 255, 255, 255);
  static const Color dark = Color.fromARGB(255, 0, 0, 0);
  static const Color primarybg = Color.fromARGB(255, 255, 252, 252);

  //bg of container color

  static const Color lightcontainer = Color.fromARGB(255, 255, 255, 255);
  static Color darkcontainer = EColors.white.withOpacity(0.1);

  //button color

  static const buttonprimary = Color.fromARGB(255, 33, 136, 253);
  static const buttonsecondary = Color.fromARGB(255, 105, 116, 129);
  static const buttondisabled = Color.fromARGB(255, 189, 193, 199);

  //error color

  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.yellow;
  static const Color info = Colors.blue;

  //nuetral

  static const Color black = Colors.black;
  static const Color darkergrey = Color.fromARGB(255, 83, 83, 83);
  static const Color darkgrey = Color.fromARGB(255, 131, 131, 131);
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
}
