import 'package:flutter/material.dart';

Color getBudgetProgressColorState(ThemeData theme, double value) {
  if (value >= 1) {
    return theme.colorScheme.error;
  }
  if (value >= 0.75) {
    return Colors.deepOrange; // TODO: Find better colors
  }
  if (value >= 0.5) {
    return Colors.orange;
  }
  return theme.colorScheme.primary;
}

Color getBudgetTextColorState(ThemeData theme, double value) {
  if (value >= 1) {
    return theme.colorScheme.error;
  }
  if (value >= 0.75) {
    return Colors.deepOrange;
  }
  if (value >= 0.5) {
    return Colors.orange;
  }
  return const Color(0xff296c0b);
}
