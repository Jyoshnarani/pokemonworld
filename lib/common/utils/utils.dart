import 'package:flutter/material.dart';
import 'package:pokemonworld/common/app_theme/theme.dart';

class Utils {
  static const TextStyle appBoldTextStyle = TextStyle(
    fontSize: 32,
    color: AppTheme.darkTextColor,
    fontWeight: AppTheme.semiBold,
    letterSpacing: 2,
  );

  static const TextStyle headline1TextStyle = TextStyle(
    fontSize: 16,
    color: AppTheme.darkFillColor,
    fontWeight: AppTheme.regularWeight,
  );

  static const TextStyle headline2TextStyle = TextStyle(
    fontSize: 12,
    color: AppTheme.darkFillColor,
    fontWeight: AppTheme.bold,
  );

  static const TextStyle title1TextStyle = TextStyle(
    fontSize: 16,
    color: AppTheme.darkFillColor,
    fontWeight: AppTheme.bold,
  );

  static const TextStyle title2TextStyle = TextStyle(
    fontSize: 12,
    color: AppTheme.darkFillColor,
    fontWeight: AppTheme.regularWeight,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontSize: 12,
    color: AppTheme.hintColor,
    fontWeight: AppTheme.regularWeight,
  );
}
