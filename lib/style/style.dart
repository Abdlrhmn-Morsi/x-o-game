import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

abstract class Style {
  static final myFontOne = GoogleFonts.pressStart2p(
    textStyle:
        const TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 3),
  );
  static final myFontSplach = GoogleFonts.pressStart2p(
    textStyle:
        const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 3),
  );
  static final myFontSplach2 = GoogleFonts.pressStart2p(
    textStyle:
        const TextStyle(color: Colors.white, fontSize: 10, letterSpacing: 3),
  );
  static final PLAYNOW = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(color: Color(0xffFCD900), letterSpacing: 3,fontSize: 12),
  );

  static var mainColor = Colors.black;
  static var litColor = Colors.white;
}
