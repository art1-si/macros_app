import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  brightness: Brightness.light,
  dialogBackgroundColor: Color(0xff232323),
  backgroundColor: Color(0xff1E2438),
  primaryColor: Color(0xff21273D),
  primaryColorLight: Color(0xff272E48),
  primaryColorDark: Color(0xff1A1F30),
  dividerColor: Color(0xff252C45),
  cardColor: Color(0xff303956),
  accentColor: Color(0xffECC75A),
  canvasColor: Color(0xff21273D),
  textTheme: TextTheme(
    headline1: GoogleFonts.lato(
      color: Color(0xff92BCD3),
      fontSize: 24,
      fontWeight: FontWeight.w300,
    ),
    headline2: GoogleFonts.lato(
      color: Color(0xff92BCD3),
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    headline3: GoogleFonts.lato(
      color: Color(0xff92BCD3),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    headline4: GoogleFonts.lato(
      color: Colors.white,
    ),
    headline5: GoogleFonts.lato(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline6: GoogleFonts.lato(
      color: Colors.white,
    ),
    bodyText1: GoogleFonts.lato(
      color: Colors.white,
    ),
    bodyText2: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.7),
      fontWeight: FontWeight.w400,
    ),
    caption: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.4),
    ),
    overline: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.4),
      letterSpacing: 0.25,
    ),
    subtitle1: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.4),
      fontWeight: FontWeight.w400,
    ),
    subtitle2: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.4),
      fontWeight: FontWeight.w400,
    ),
  ),
);

final lightTheme = ThemeData(
  dialogBackgroundColor: Color(0xff0B1F2B),
  brightness: Brightness.light,
  backgroundColor: Color(0xff091a24),
  primaryColor: Color(0xff0B1F2B),
  primaryColorLight: Color(0xff0D2533),
  primaryColorDark: Color(0xff0C2533),
  bottomAppBarColor: Color(0xff1B273B),
  dividerColor: Color(0xff0C2533),
  cardColor: Color(0xff0B1F2B),
  accentColor: Color(0xffF9F871),
  canvasColor: Color(0xff0B1F2B),
  textTheme: TextTheme(
    headline1: GoogleFonts.lato(
      color: Color(0xff65ABD7),
      fontSize: 24,
      fontWeight: FontWeight.w300,
    ),
    headline2: GoogleFonts.lato(
      color: Color(0xff65ABD7),
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    headline3: GoogleFonts.lato(
      color: Color(0xff65ABD7),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    headline4: GoogleFonts.lato(
      color: Colors.white,
      letterSpacing: 0,
      height: 1.1,
    ),
    headline5: GoogleFonts.lato(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline6: GoogleFonts.lato(
      color: Colors.white,
    ),
    bodyText1: GoogleFonts.lato(
      color: Colors.white,
    ),
    bodyText2: GoogleFonts.lato(
      color: Color(0xff65ABD7).withOpacity(0.77),
      fontWeight: FontWeight.w400,
    ),
    caption: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.46),
    ),
    overline: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.46),
      letterSpacing: 0.25,
    ),
    subtitle1: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w400,
    ),
    subtitle2: GoogleFonts.lato(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w400,
    ),
  ),
);
