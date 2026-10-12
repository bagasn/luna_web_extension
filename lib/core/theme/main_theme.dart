import 'package:flutter/material.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/generated/fonts.gen.dart';

part 'text_theme.dart';
part 'button_theme.dart';

final ThemeData kAppThemeData = ThemeData(
  useMaterial3: true,

  // Color Theme
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor).copyWith(
    primary: AppColors.mainColor,
    onPrimary: Colors.white,
    secondary: AppColors.mainColor,
    onSecondary: Colors.white,
    error: AppColors.red700,
    onError: Colors.white,
  ),

  // App Bar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.textDark,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black87,
    elevation: 2,
    scrolledUnderElevation: 2,
    centerTitle: false,
  ),

  // Scaffold Style
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  canvasColor: AppColors.scaffoldBackground,

  // Bottom Sheet Style
  bottomSheetTheme: const BottomSheetThemeData(
    modalBackgroundColor: AppColors.scaffoldBackground,
  ),

  // Font & Text Style
  fontFamily: AppFonts.inter,
  textTheme: _textTheme,

  // Button Style
  elevatedButtonTheme: _elevatedButtonThemeData,
  filledButtonTheme: _filledButtonThemeData,
  textButtonTheme: _textButtonThemeData,
  outlinedButtonTheme: _outlineButtonThemeData,

  // Dialog Style
  dialogTheme: const DialogThemeData(
    backgroundColor: AppColors.scaffoldBackground,
  ),

  // Chip Style
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    iconTheme: IconThemeData(color: AppColors.iconDark),
  ),
);
