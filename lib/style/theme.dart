import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeStyle {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? ThemeData(
            primarySwatch: Colors.grey,
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            backgroundColor: const Color(0xFF212121),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0xff896277), // Your accent color
            ),
            dividerColor: Colors.black12,
            textTheme: TextTheme(
              headline1: GoogleFonts.roboto(
                fontSize: 42,
                fontWeight: FontWeight.w600,
              ),
              headline2: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              bodyText1: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              bodyText2: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0xff896277), // Your accent color
            ),
            dividerColor: Colors.white60,
            textTheme: TextTheme(
              headline1: GoogleFonts.roboto(
                fontSize: 42,
                fontWeight: FontWeight.w600,
              ),
              headline2: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              bodyText1: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              bodyText2: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ));
  }
}
