import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_project/core/theme/C.dart';

class FontTheme {
  static TextTheme get textTheme {
    //------------used google font for the arabic text ---------------------
    return TextTheme(
      //---------------------  titel  --------------------------------------
      displayLarge: GoogleFonts.almarai(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: C.black,
      ),
      displayMedium: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: C.black,
      ),
      displaySmall: GoogleFonts.almarai(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: C.black,
      ),

      //------------------------ mian text  --------------------------------------------
      headlineLarge: GoogleFonts.almarai(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: C.black,
      ),
      headlineMedium: GoogleFonts.almarai(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: C.black,
      ),
      headlineSmall: GoogleFonts.almarai(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: C.black,
      ),

      //------------------------ body text --------------------------------------------
      bodyLarge: GoogleFonts.almarai(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: C.black,
      ),
      bodyMedium: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: C.black,
      ),
      bodySmall: GoogleFonts.almarai(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: C.black,
      ),
    );
  }
}
