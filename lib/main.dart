import 'dart:ui';

import 'package:facts/SplashScreen.dart';
import 'package:facts/app_factory.dart';
import 'package:facts/atoms/popup.dart';
import 'package:facts/player_lab/model/screen_playerlab.dart';
import 'package:facts/atoms/blinking_text.dart';
import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/timer.dart';
import 'package:facts/data/model.dart';
import 'package:facts/game.dart';
import 'package:facts/message_board/widget/animated_message.dart';
import 'package:facts/episode_food_vlogger_intro.dart';
import 'package:facts/lesson_food_vlogger.dart';
import 'package:facts/episode_food_vlogger_carousel.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/lesson_food_vlogger_end.dart';
import 'package:facts/manager_audio.dart';
import 'package:facts/manager_plausible_analytics.dart';
import 'package:facts/message_board/widget/message_board.dart';
import 'package:facts/puzzle_colorbalance.dart';
import 'package:facts/puzzle_lens_ela.dart';
import 'package:facts/puzzle_lens_exposure.dart';
import 'package:facts/puzzle_pan_and_draw.dart';
import 'package:facts/puzzle_find_object.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(background: Color.fromARGB(255, 42, 20, 27)),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'MESSAGE BOARD',
        level: 0,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  int level = 0;

  MyHomePage({super.key, required this.title, required this.level});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = -1;
  final factory = AppFactory();
  late ManagerAudio audioManager;
  late PlausibleAnalytics analyticsManager;
  late RouterLevel levelRouter;
  late Content content;
  bool showPopup = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void onLevelFinished(details) {
    // setState(() {
    //   _counter++;
    // });
    if (details == "success") {
      audioManager.playSuccess();
    } else if (details == "fail") {
      audioManager.playFailure();
    } else if (details == "neutral") {
      audioManager.playMain();
    } else if (details == "mute") {
      audioManager.mute();
    }
  }

  void onEvent(event, payload) {
    print("$event, $payload");
    analyticsManager.logStart();
  }

  @override
  void initState() {
    super.initState();
    factory.init();
    audioManager = factory.audioManager;
    analyticsManager = factory.analyticsManager;
    levelRouter = factory.levelRouter;
    setState(() {
      content = levelRouter.content;
    });
    audioManager.playMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 20, 27),
        title: Column(
          children: [
            Text(levelRouter.pageType == 0 ? "MESSAGE BOARD" : "REC",
                style: GoogleFonts.pressStart2p(
                    color: Color.fromARGB(255, 178, 43, 42),
                    textStyle: TextStyle(fontSize: 18.0)))
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: ColoredBox(
                color: Color.fromARGB(255, 42, 20, 27),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 200,
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 12.0),
                  child: Builder(builder: (context) {
                    switch (_counter) {
                      case -1:
                        // return PageTest(
                        //     onFinish: onLevelFinished, onEvent: onEvent);
                        // return MessageBoard(level: widget.level);
                        return Game(
                          level: levelRouter,
                        );
                      // return Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     BlinkingText(),
                      //     Expanded(child: Container()),
                      //     Timer(
                      //       key: ValueKey(levelRouter.levelNumber),
                      //     ),
                      //   ],
                      // );
                      // return PuzzleColorBalance(onPuzzleDone: _incrementCounter);
                      case 0:
                        return SplashScreen(
                          onFinish: onLevelFinished,
                        );
                      case 1:
                        return LessonFoodVlogger(onFinish: onLevelFinished);
                      case 2:
                        return EpisodeFoodVloggerIntro(
                            onFinish: onLevelFinished);
                      case 3:
                        return PuzzlePandAndDraw(
                          onPuzzleDone: _incrementCounter,
                        );
                      case 4:
                        return PuzzleLensExposure(
                          onPuzzleDone: _incrementCounter,
                        );
                      case 5:
                        return PuzzleLensELA(
                          onPuzzleDone: _incrementCounter,
                        );
                      case 6:
                        return PuzzleColorBalance(
                            onPuzzleDone: _incrementCounter);
                    }
                    return LessonFoodVloggerEnd(onFinish: onLevelFinished);
                  }),
                ),
              )),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 109, 20, 20),
                  ),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Heading("L${levelRouter.levelNumber}"),
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        size: 80,
                        color: Colors.redAccent,
                      ),
                      AccentButton(
                          label: "Next",
                          onClick: () {
                            // var nextLevel = levelRouter.nextLevel();
                            setState(() {
                              // levelRouter = nextLevel;
                              showPopup = true;
                            });
                          }),
                    ],
                  ))
            ],
          ),
          Popup(
            key: ValueKey(showPopup),
            show: showPopup,
            onClose: () {
              setState(() {
                print('false');
                showPopup = false;
              });
            },
          )
        ],
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
