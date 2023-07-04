import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTheme {
  static const primaryColor = Colors.blue;
  static const white = Colors.white;
  static const black = Colors.black;
  static const lightPink = Color(0xFFF8E8EE);
  static const tealGreen = Color(0xff2E8A99);
  static const deepRed = Color(0xFFCD1818);
  static const deepBrown = Color(0xFF2B2730);

  static ThemeData appTheme(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: white,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(color: white),
            actionsIconTheme: IconThemeData(color: white)),
      );

  //fonts
  static final poppins = GoogleFonts.poppins();
}

extension CustomTextTheme on TextTheme {
  TextStyle get body => TextStyle(
      fontSize: 14,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400);
}
