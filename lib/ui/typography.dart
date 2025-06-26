import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static const fontFamily = 'Lexend';

  static final textTheme = TextTheme(
    displayLarge: display,
    displayMedium: display.copyWith(fontSize: 45),
    displaySmall: display.copyWith(fontSize: 36),
    headlineLarge: headline,
    headlineMedium: headline.copyWith(fontSize: 28),
    headlineSmall: headline.copyWith(fontSize: 24),
    titleLarge: title,
    titleMedium: title.copyWith(fontSize: 16),
    titleSmall: title.copyWith(fontSize: 14),
    bodyLarge: body,
    bodyMedium: body.copyWith(fontSize: 14),
    bodySmall: body.copyWith(fontSize: 12),
    labelLarge: label,
    labelMedium: label.copyWith(fontSize: 12),
    labelSmall: label.copyWith(fontSize: 11),
  );

  /// Base Text Style
  static final _default = GoogleFonts.lexend(
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  /// Display Text Style
  static final TextStyle display = _default.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle headline = _default.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle title = _default.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle body = _default.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle label = _default.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
