import 'dart:io';

import 'package:facts/atoms/blinking_text.dart';
import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/timer.dart';
import 'package:facts/player_lab/artboard_manager.dart';
import 'package:facts/player_lab/image_comparator.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/widget/test_art_board.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/widgets.dart';

class TestLab extends StatefulWidget {
  final Function? onFinish;
  final Function? onEvent;
  final RouterLevel level;
  TestLab({super.key, this.onFinish, this.onEvent, required this.level});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<TestLab> {
  late PlayerLabCanvas playerCanvas;
  late PlayerLabCanvas targetCanvas;
  late Function? comparator;
  // File? previewFile;
  double score = 0.0;

  @override
  void initState() {
    super.initState();
    playerCanvas = widget.level.content.labCanvas![0]!;
    targetCanvas = widget.level.content.labCanvas![1]!;
    comparator = widget.level.content.comparatorV2;
    setState(() {});
  }

  @override
  void dispose() {}

  void onChange(double result) {
    setState(() {
      // previewFile = newFile;
      score = result;
    });
  }

  void redraw() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlinkingText(),
                Expanded(child: Container()),
                Timer(
                  key: ValueKey(widget.level.levelNumber),
                ),
              ],
            ),
            Container(
              child: CanvasLabel("TARGET IMAGE"),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
            ),
            TestArtBoard(
              canvas: targetCanvas,
              onChange: redraw,
            ),

            Container(
              child: CanvasLabel("YOUR CANVAS"),
              margin: EdgeInsets.fromLTRB(0, 12, 0, 8),
            ),
            TestArtBoard(
              canvas: playerCanvas,
              onChange: redraw,
            ),

            // if (previewFile != null) Image.file(previewFile!)
            // Text(
            //   "score $score",
            //   style: TextStyle(color: Color.fromARGB(255, 255, 255, 123)),
            // )
          ],
        )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
          alignment: Alignment.bottomRight,
          child: AccentButton(
              label: "Submit",
              onClick: () {
                bool result = comparator?.call(playerCanvas, targetCanvas);
                print("submission result : $result");
                widget.onFinish!(result);
              }),
        )
      ],
    );
  }
}
