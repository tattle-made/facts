import 'package:facts/atoms/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget AppName(text) {
  return Text(
    text,
    style: GoogleFonts.ibmPlexMono(
        textStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic)),
  );
}

Widget Heading1PrimaryFontWhite(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w500)));
}

Widget Heading2PrimaryFontWhite(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(color: Colors.white, fontSize: 20.0)));
}

Widget Heading2White(text) {
  return Text(text,
      style: GoogleFonts.pressStart2p(
          textStyle: TextStyle(color: Colors.white, fontSize: 16.0)));
}

Widget Heading2Black(text) {
  return Text(text,
      style: GoogleFonts.pressStart2p(
          textStyle: TextStyle(color: black, fontSize: 16.0)));
}

Widget HeadingAlt2White(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(
              color: Color.fromARGB(255, 255, 87, 51),
              fontSize: 24.0,
              fontWeight: FontWeight.w500)));
}

Widget AccentButtonText(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(
              color: Color.fromARGB(255, 178, 43, 42),
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic)));
}

Widget SimpleButtonText(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(
              color: secondary,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic)));
}
