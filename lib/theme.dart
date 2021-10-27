import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColor: AppColors.primaryColor,
  primaryColorDark: AppColors.primaryColor,
  disabledColor: AppColors.grey,
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: MaterialColor(0xFFEC0101, {
    50: AppColors.primaryColor,
    100: AppColors.primaryColor,
    200: AppColors.primaryColor,
    300: AppColors.primaryColor,
    400: AppColors.primaryColor,
    500: AppColors.primaryColor,
    600: AppColors.primaryColor,
    700: AppColors.primaryColor,
    800: AppColors.primaryColor,
    900: AppColors.primaryColor,
  }),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);
