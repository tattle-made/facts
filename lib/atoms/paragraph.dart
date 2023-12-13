import 'package:facts/atoms/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget Paragraph(text) {
  return Text(
    text,
    style: GoogleFonts.ibmPlexMono(
        textStyle: TextStyle(
            color: white,
            fontSize: 24.0,
            height: 1.2,
            fontWeight: FontWeight.w400)),
  );
}
