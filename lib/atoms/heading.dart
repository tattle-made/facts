import 'package:facts/atoms/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget Heading(text) {
  return Text(
    text,
    style: GoogleFonts.ibmPlexMono(
        textStyle:
            TextStyle(color: Color.fromARGB(255, 238, 204, 0), fontSize: 24.0)),
  );
}

Widget Heading2(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(
              color: Color.fromARGB(255, 238, 204, 0),
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic)));
}

Widget SenderLabel(text) {
  return Text(
    text.toString().toUpperCase(),
    style: GoogleFonts.pressStart2p(
        textStyle: TextStyle(color: black, fontSize: 18.0)),
  );
}

Widget CanvasLabel(text) {
  return Text(text,
      style: GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(
        color: primary,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      )));
}
