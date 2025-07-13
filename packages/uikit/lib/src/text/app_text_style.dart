//ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// App text style.
enum AppTextStyle {
  displayLarge(TextStyle(fontSize: 57, height: 57 / 64)),
  displayMedium(TextStyle(fontSize: 45, height: 45 / 52)),
  displaySmall(TextStyle(fontSize: 36, height: 36 / 44)),
  headlineLarge(TextStyle(fontSize: 32, height: 32 / 40)),
  headlineMedium(TextStyle(fontSize: 28, height: 28 / 36)),
  headlineSmall(TextStyle(fontSize: 24, height: 24 / 32)),
  titleLarge(TextStyle(fontSize: 22, height: 22 / 28)),
  titleMedium(
    TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 16 / 24,
    ),
  ),
  titleSmall(
    TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 14 / 20,
    ),
  ),
  labelLarge(
    TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 14 / 20,
    ),
  ),
  labelMedium(
    TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 12 / 16,
    ),
  ),
  labelSmall(
    TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 11 / 16,
    ),
  ),
  bodyLarge(TextStyle(fontSize: 16, height: 16 / 24)),
  bodyMedium(TextStyle(fontSize: 14, height: 14 / 20)),
  bodySmall(TextStyle(fontSize: 12, height: 12 / 16));

  final TextStyle value;

  const AppTextStyle(this.value);
}
