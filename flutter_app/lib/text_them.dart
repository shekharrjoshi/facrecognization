import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    labelLarge: GoogleFonts.montserrat(color: Colors.white),
    labelSmall: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 24),
  );
  static TextTheme darkTextTheme = TextTheme(
    labelLarge: GoogleFonts.montserrat(color: Colors.white70),
    labelSmall: GoogleFonts.poppins(color: Colors.white60, fontSize: 24),
  );
}

