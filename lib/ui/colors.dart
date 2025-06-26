import 'dart:ui';

import 'package:flutter/material.dart';

/// App color palette. These colors can and should be used to construct a custom Theme
abstract class AppColors {
  static const primaryContainer = Color(0xFF242437);
  static const primary = Color(0xFF9191E5);
  static const secondaryContainer = Color(0xFFF6F7FB);
  static final onSecondaryContainer = Colors.grey.shade900;
  static const container = Color(0xFFE9E9F4);
  static const headerText = Color(0xFF2B3445);
  static const bodyText = Color(0xFF323233);
  static const scaffold = Color(0xFF242437);
  static const surface = Color(0xFF242437);
  static const onSurface = Colors.white;
  static const inputUnfocused = Color(0xFFDCE8E2);
  static const boxShadow = Color.fromARGB(143, 34, 34, 33);
  static const radioUnselected = Color(0xFFA8A8A8);
}
