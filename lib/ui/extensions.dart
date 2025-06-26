import 'package:flutter/material.dart';

extension TextStyleX on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle color(Color color) => copyWith(color: color);
}
