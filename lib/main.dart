import 'dart:ui';

import 'package:facts/episode_food_vlogger.dart';
import 'package:facts/episode_food_vlogger_carousel.dart';
import 'package:facts/episode_food_vlogger_puzzles.dart';
import 'package:facts/puzzle_find_object.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'facts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 201, 203, 163),
        title: Text(widget.title,
            style: GoogleFonts.pressStart2p(
                textStyle: TextStyle(
                    color: Color.fromARGB(255, 71, 45, 48), fontSize: 40.0))),
      ),
      body: ColoredBox(
          color: Color.fromARGB(255, 201, 203, 163),
          child: Column(
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     const Text(
              //       'You have pushed the button this many times',
              //     ),
              //     Text(
              //       '$_counter',
              //       style: Theme.of(context).textTheme.headlineMedium,
              //     ),
              //   ],
              // ),
              Container(
                color: Colors.redAccent,
                alignment: Alignment.center,
                width: double.infinity,
                height: 4 / 5 * MediaQuery.of(context).size.height,
                child: PuzzleFindObject(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2/5',
                      style: GoogleFonts.pressStart2p(
                          textStyle: const TextStyle(
                              fontSize: 24.0,
                              color: Color.fromARGB(255, 71, 45, 48),
                              backgroundColor: Colors.redAccent)),
                      textAlign: TextAlign.start,
                    )
                    // Text('Score Goes Here',
                    //     style: TextStyle(
                    //       fontSize: 24.0,
                    //     )),
                    // Text('Score Goes Here',
                    //     style: TextStyle(
                    //       fontSize: 24.0,
                    //     ))
                  ],
                ),
              )
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
