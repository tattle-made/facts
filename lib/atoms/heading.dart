import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var headingStyle = GoogleFonts.pressStart2p(
    textStyle:
        TextStyle(color: Color.fromARGB(255, 71, 45, 48), fontSize: 24.0));

Widget Heading(text) {
  return Text(
    text,
    style: headingStyle,
  );
}
