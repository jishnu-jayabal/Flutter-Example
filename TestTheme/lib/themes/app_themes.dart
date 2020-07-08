import 'package:flutter/material.dart';

enum AppThemes {
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark
}

final appThemes = {
  AppThemes.GreenLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green[600]
  ),
    AppThemes.GreenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[900]
  ),
    AppThemes.BlueLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[600]
  ),
    AppThemes.BlueDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[900]
  ),

};