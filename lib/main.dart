import 'dart:ui';

import 'package:facts/episode_food_vlogger_intro.dart';
import 'package:facts/lesson_food_vlogger.dart';
import 'package:facts/episode_food_vlogger_carousel.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/lesson_food_vlogger_end.dart';
import 'package:facts/puzzle_colorbalance.dart';
import 'package:facts/puzzle_lens_ela.dart';
import 'package:facts/puzzle_lens_exposure.dart';
import 'package:facts/puzzle_pan_and_draw.dart';
import 'package:facts/puzzle_find_object.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'facts!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void onLevelFinished() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 201, 203, 163),
        title: Column(
          children: [
            Text(widget.title,
                style: GoogleFonts.pressStart2p(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 45, 48),
                        fontSize: 32.0)))
          ],
        ),
      ),
      body: ColoredBox(
        color: Color.fromARGB(255, 201, 203, 163),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Builder(builder: (context) {
            switch (_counter) {
              case 0:
                return LessonFoodVlogger(onFinish: onLevelFinished);
              case 1:
                return EpisodeFoodVloggerIntro(onFinish: onLevelFinished);
              case 2:
                return PuzzlePandAndDraw(
                  onPuzzleDone: _incrementCounter,
                );
              case 3:
                return PuzzleLensExposure(
                  onPuzzleDone: _incrementCounter,
                );
              case 4:
                return PuzzleLensELA(
                  onPuzzleDone: _incrementCounter,
                );
              case 5:
                return PuzzleColorBalance(onPuzzleDone: _incrementCounter);
            }
            return LessonFoodVloggerEnd(onFinish: onLevelFinished);
          }),
        ),
      ),
    );
  }
}

Widget levelSelector(level, onLevelFinished) {
  switch (level) {
    case 0:
      return LessonFoodVlogger(onFinish: onLevelFinished);
    case 1:
      return PuzzlePandAndDraw();
  }
  return LessonFoodVlogger(onFinish: onLevelFinished);
}
