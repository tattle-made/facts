import 'dart:ui';

import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:facts/atoms/theme.dart';
import 'package:facts/atoms/typography.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final Function? onFinish;
  const SplashScreen({super.key, this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return _EpisodeState();
  }
}

class _EpisodeState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: _Lesson(onFinish: widget.onFinish),
    );
  }
}

class _Lesson extends StatelessWidget {
  final Function? onFinish;
  const _Lesson({super.key, this.onFinish});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Heading1PrimaryFontWhite(
            "Factual Accuracy Checking Tutorials by Tattle"),
        Container(height: 24),
        HeadingAlt2White("Games to sharpen your Media Literacy skills. \n"),
        Container(height: 32),
        Heading2PrimaryFontWhite("Supported By : "),
        Container(
          color: white,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Image.asset('assets/support.png'),
        ),
        Container(height: 64),
        SimpleButton(
            label: "Home",
            onClick: () {
              onFinish?.call();
            }),
        const SizedBox(
          height: 100,
          width: 20,
        )
      ],
    );
  }
}

var paraStyle = GoogleFonts.raleway(
    textStyle: TextStyle(
        color: Color.fromARGB(255, 71, 45, 48),
        fontSize: 16.0,
        height: 1.2,
        fontWeight: FontWeight.w600));
