import 'package:flutter/material.dart';

class ETextTheme {
  ETextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF25291C)),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF25291C)),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF25291C)),
    titleLarge: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF25291C)),
    titleMedium: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF25291C)),
    titleSmall: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: const Color(0xFF25291C)),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF25291C)),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF25291C)),
    bodySmall: const TextStyle().copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF25291C)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF25291C)),
    labelMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF25291C)),
    labelSmall: const TextStyle().copyWith(
        fontSize: 8,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF25291C)),
  );

  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF25291C)),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF25291C)),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF25291C)),
      titleLarge: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF25291C)),
      titleMedium: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF25291C)),
      titleSmall: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF25291C)),
      bodyLarge: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF25291C)),
      bodyMedium: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF25291C)),
      bodySmall: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF25291C)),
      labelLarge: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF25291C)),
      labelMedium: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w200,
          color: const Color(0xFF25291C)),
      labelSmall: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w100,
          color: const Color(0xFF25291C)));
}
