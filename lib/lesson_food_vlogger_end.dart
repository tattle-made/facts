import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonFoodVloggerEnd extends StatefulWidget {
  final Function? onFinish;
  const LessonFoodVloggerEnd({super.key, this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return _EpisodeState();
  }
}

class _EpisodeState extends State<LessonFoodVloggerEnd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 201, 203, 163),
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
        Heading("Conclusion"),
        Paragraph(
            "\nWhat you saw here were images from a vlog being manipulated to invent new meaning and spread misinformation. Through these challenges you have proved yourself to be capable of being a careful detective.\n"),
        Paragraph("\nSee you again on the next mission.\n"),
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
