import 'dart:io';

import 'package:facts/atoms/button.dart';
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
  File? previewFile;

  @override
  void initState() {
    super.initState();
    playerCanvas = widget.level.content.labCanvas![0]!;
    targetCanvas = widget.level.content.labCanvas![1]!;
    setState(() {});
  }

  @override
  void dispose() {}

  void onChange(File newFile) {
    setState(() {
      previewFile = newFile;
    });
  }

  void redraw() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TestArtBoard(
          canvas: targetCanvas,
          onChange: redraw,
        ),
        Container(
          height: 40,
        ),
        TestArtBoard(
          canvas: playerCanvas,
          onChange: redraw,
        ),
        Button(
            label: "test",
            onClick: () async {
              // compare(targetImage, w, h, artboard)
              var width = MediaQuery.of(context).size.width;
              var height = 170 / 297 * MediaQuery.of(context).size.width;
              // print("testing $width, $height");
              // print(playerCanvas);
              // print(targetCanvas);
              await compare(
                  targetCanvas, width, height, playerCanvas, onChange);
            }),
        if (previewFile != null) Image.file(previewFile!)
      ],
    );
  }
}
