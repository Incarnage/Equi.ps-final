import 'package:equips_v2/utilities/theme/cthemes/appbar_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/bottom_sheet_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/checkbox_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/chip_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/e_button_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/o_button_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/text_field_theme.dart';
import 'package:equips_v2/utilities/theme/cthemes/text_theme.dart';
import 'package:flutter/material.dart';

class ETheme {
  ETheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: ETextTheme.lightTextTheme,
    chipTheme: EChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: EAppbarTheme.lightAppbar,
    checkboxTheme: ECheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomTheme,
    elevatedButtonTheme: EeButtonTheme.lightButton,
    outlinedButtonTheme: EoButtonTheme.lightoButtonTheme,
    inputDecorationTheme: ETextformTheme.lightInputDecorationTheme,
  );
}
