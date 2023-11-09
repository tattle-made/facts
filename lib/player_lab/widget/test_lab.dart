import 'package:facts/player_lab/artboard_manager.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/widget/test_art_board.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/widgets.dart';

class TestLab extends StatefulWidget {
  final Function? onFinish;
  final Function? onEvent;
  final RouterLevel level;
  TestLab(
      {super.key, this.onFinish, this.onEvent, required this.level});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<TestLab> {
  late PlayerLabCanvas playerCanvas;
  late PlayerLabCanvas targetCanvas;


  @override
  void initState() {
    super.initState();
    playerCanvas = widget.level.content.labCanvas![0]!;
    targetCanvas = widget.level.content.labCanvas![1]!;
    setState(() {});
  }

  @override
  void dispose() {}

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
          canvas: playerCanvas,
          onChange: redraw,
        ),
        Container(
          height: 40,
        ),
      ],
    );
  }
}
