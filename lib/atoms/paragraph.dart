import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var paraStyle = GoogleFonts.raleway(
    textStyle: TextStyle(
        color: Color.fromARGB(255, 71, 45, 48),
        fontSize: 24.0,
        height: 1.2,
        fontWeight: FontWeight.w600));

Widget Paragraph(text) {
  return Text(
    text,
    style: paraStyle,
  );
}
