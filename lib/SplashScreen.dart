import 'dart:ui';

import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
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
        Heading("Factual Accuracy Checking Tutorials"),
        Paragraph(
            "An interactive tutorial about media literacy built by Tattle \n"),
        Paragraph("Supported By : "),
        Image.asset('assets/support.png'),
        GestureDetector(
            onTap: () {
              onFinish?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 225, 168),
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 0, 0), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
              child: const Row(
                children: [
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Color.fromARGB(255, 114, 61, 70),
                    size: 48.0,
                    semanticLabel: 'Draw Rectangle',
                  ),
                  const Text("Explore")
                ],
              ),
            )),
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
