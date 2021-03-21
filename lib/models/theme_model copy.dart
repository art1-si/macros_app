import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Color(0xff0F1521),
  primaryColor: Color(0xff151D2E),
  primaryColorDark: Color(0xff090D14).withOpacity(0.5),
  bottomAppBarColor: Color(0xff1B273B),
  dividerColor: Color(0xff090D14).withOpacity(0.5),
  cardColor: Colors.white,
  accentColor: Color(0xffF4C95D),
  canvasColor: Color(0xff151D2E),
  textTheme: TextTheme(
    headline1: GoogleFonts.ubuntu(
      color: Colors.white,
      fontSize: 34,
      fontWeight: FontWeight.w400,
    ),
    headline2: GoogleFonts.lato(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
    headline3: GoogleFonts.lato(
        color: Color(0xff668CD9), fontSize: 17, fontWeight: FontWeight.w800),
    headline4: GoogleFonts.lato(
        color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
    headline5: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.lato(
        color: Color(0xff90A4CB), fontSize: 10.0, fontWeight: FontWeight.w300),
    bodyText1: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.lato(
      color: Color(0xff668CD9),
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    caption: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.w400,
    ),
  ),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Color(0xff0D1924),
  primaryColor: Color(0xff122130),
  primaryColorDark: Color(0xff091118).withOpacity(0.5),
  dividerColor: Color(0xff091118).withOpacity(0.5),
  bottomAppBarColor: Color(0xff122130),
  cardColor: Color(0xff122130),
  accentColor: Color(0xffCAA8F5),
  canvasColor: Color(0xff122130),
  errorColor: Color(0xffFF5E5E),
  textTheme: TextTheme(
    headline1: GoogleFonts.ubuntu(
      color: Colors.white,
      fontSize: 34,
      fontWeight: FontWeight.w400,
    ),
    headline2: GoogleFonts.lato(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
    headline3: GoogleFonts.lato(
        color: Color(0xff5389BF), fontSize: 17, fontWeight: FontWeight.w800),
    headline4: GoogleFonts.lato(
        color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
    headline5: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.lato(
        color: Color(0xffBAD0E6), fontSize: 10.0, fontWeight: FontWeight.w300),
    bodyText1: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.lato(
      color: Color(0xff5389BF),
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    caption: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.w400,
    ),
  ),
);
