import 'dart:ui';

import 'package:facts/page_about.dart';
import 'package:facts/app_factory.dart';
import 'package:facts/atoms/popup.dart';
import 'package:facts/atoms/show_if.dart';
import 'package:facts/atoms/typography.dart';
import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/data/model.dart';
import 'package:facts/game.dart';
import 'package:facts/episode_food_vlogger_intro.dart';
import 'package:facts/game/model/page.dart' as facts_page;
import 'package:facts/page_lesson_image_manipulation.dart';
import 'package:facts/lesson_food_vlogger_end.dart';
import 'package:facts/manager_audio.dart';
import 'package:facts/manager_plausible_analytics.dart';
import 'package:facts/page_home.dart';
import 'package:facts/puzzle_colorbalance.dart';
import 'package:facts/puzzle_lens_ela.dart';
import 'package:facts/puzzle_lens_exposure.dart';
import 'package:facts/puzzle_pan_and_draw.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  var currentPage = facts_page.Page.HOME;
  final factory = AppFactory();
  late ManagerAudio audioManager;
  late PlausibleAnalytics analyticsManager;
  late RouterLevel levelRouter;
  late Content content;
  bool showPopup = false;
  MessagePopupScreen messagePopupScreen = MessagePopupScreen();
  int score = 0;

  String heading() {
    String heading;
    if (currentPage == facts_page.Page.GAME) {
      heading = levelRouter.pageType == 0
          ? "facts! > chatroom"
          : "facts! > laboratory";
    } else {
      return "facts!";
    }

    return heading;
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

  onPageFinished() {
    setState(() {
      currentPage = facts_page.Page.HOME;
    });
  }

  onPageChangeRequest(facts_page.Page newPage) {
    setState(() {
      currentPage = newPage;
    });
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

  void onImageSubmitted(bool result) {
    print("image submitted as $result");
    MessagePopupScreen message;
    int incr = 0;
    if (result) {
      message = levelRouter.content.messageResult.success;
      incr++;
    } else {
      message = levelRouter.content.messageResult.failure;
    }

    setState(() {
      messagePopupScreen = message;
      showPopup = true;
      score = score + incr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 178, 43, 42),
        title: Container(
          alignment: Alignment.center,
          child: AppName(heading()),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  ShowIf(
                      condition: currentPage == facts_page.Page.GAME,
                      child: Container(
                        color: Color.fromARGB(255, 178, 43, 42),
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Heading2("level:${levelRouter.levelNumber}"),
                            Heading2("score:${score}")
                          ],
                        ),
                      ))
                ],
              ),
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
                    switch (currentPage) {
                      case facts_page.Page.HOME:
                        return PageHome(
                          onFinish: onPageFinished,
                          onChangePage: onPageChangeRequest,
                        );
                      case facts_page.Page.LESSON:
                        return PageLessonImageManipulation(
                          onFinish: onPageFinished,
                        );
                      case facts_page.Page.GAME:
                        return Game(
                          level: levelRouter,
                          onFinish: onImageSubmitted,
                        );

                      case facts_page.Page.ABOUT:
                        return SplashScreen(
                          onFinish: onPageFinished,
                        );
                      case facts_page.Page.END:
                        return LessonFoodVloggerEnd(onFinish: onLevelFinished);
                      default:
                        return SplashScreen(
                          onFinish: onLevelFinished,
                        );
                    }
                  }),
                ),
              )),
              currentPage == facts_page.Page.GAME &&
                      levelRouter.content.type == ContentType.message
                  ? Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 42, 20, 27),
                      ),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          levelRouter.content.type == ContentType.message
                              ? AccentButton(
                                  label: "next",
                                  onClick: () {
                                    print(showPopup);
                                    levelRouter.nextLevel();
                                    setState(() {});
                                  })
                              : Container(),
                        ],
                      ))
                  : Container()
            ],
          ),
          Popup(
            key: ValueKey(showPopup),
            show: showPopup,
            message: messagePopupScreen,
            onClose: () {
              var nextLevel = levelRouter.nextLevel();
              setState(() {
                print('false in on close');
                levelRouter = nextLevel;
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
      return PageLessonImageManipulation(onFinish: onLevelFinished);
    case 1:
      return PuzzlePandAndDraw();
  }
  return PageLessonImageManipulation(onFinish: onLevelFinished);
}
