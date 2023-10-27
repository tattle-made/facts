import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var headingStyle = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, fontSize: 16.0));

Widget Heading(text) {
  return Text(
    text,
    style: headingStyle,
  );
}

var heading2Style = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, fontSize: 12.0));

Widget Heading2(text) {
  return Text(
    text,
    style: headingStyle,
  );
}

Widget SenderLabel(text) {
  return Text(
    text.toString().toUpperCase(),
    style: GoogleFonts.pressStart2p(
        textStyle: TextStyle(color: Colors.white, fontSize: 18.0)),
  );
}
