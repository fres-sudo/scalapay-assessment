import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xFF5666F0),
      onPrimary: Colors.white,
      secondary: const Color(0xFFF6F7FB),
      onSecondary: Colors.grey.shade900,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: const Color(0xFFB00020),
      onError: Colors.white,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected)
                ? const Color(0xFF5666F0)
                : Colors.grey.shade300,
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.grey.shade200),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xFFF6F7FB),
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(120)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(120),
        borderSide: BorderSide(color: Color(0xFFEFF1F5), width: 1),
      ),
      filled: false,
      contentPadding: EdgeInsets.only(left: 16, top: 16.5, bottom: 16.5),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 0,
        backgroundColor: Color(0xFFF6F7FB),
        foregroundColor: Colors.grey.shade900,
        shadowColor: Colors.transparent,
      ),
    ),
  );
}
