import 'package:facts/player_lab/artboard_manager.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/widget/artboard.dart';
import 'package:facts/router_level.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPlayerLab extends StatefulWidget {
  final Function? onFinish;
  final Function? onEvent;
  final RouterLevel level;
  ScreenPlayerLab(
      {super.key, this.onFinish, this.onEvent, required this.level});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ScreenPlayerLab>
    with SingleTickerProviderStateMixin {
  late PlayerLabCanvas playerCanvas;
  late PlayerLabCanvas targetCanvas;
  late ArtBoardManager manager;

  void loadResources() async {
    // await playerCanvas.loadResources();
    // await targetCanvas.loadResources();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    playerCanvas = widget.level.content.labCanvas![0]!;
    targetCanvas = widget.level.content.labCanvas![1]!;
    manager = ArtBoardManager(canvas: playerCanvas);
    playerCanvas.selectionIndex = 0;
    targetCanvas.selectionIndex = 0;
    loadResources();
  }

  @override
  void dispose() {}

  void redraw() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 750),
        curve: Curves.bounceOut,
        builder: (BuildContext context, val, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 32, 0, 15),
              //   child: Text("TARGET IMAGE",
              //       style: GoogleFonts.pressStart2p(
              //           color: Color.fromARGB(255, 178, 43, 42),
              //           textStyle: TextStyle(fontSize: 12.0))),
              // ),
              // Artboard(playerCanvas: targetCanvas, onChange: redraw),
              // Container(
              //   height: 12
              // ),
              GestureDetector(
                child: ArtBoard(
                  playerCanvas: playerCanvas,
                  onChange: redraw,
                ),
                onScaleStart: (details) {
                  manager.onScaleStart(details);
                  redraw();
                },
                onScaleUpdate: (details) {
                  manager.onScaleUpdate(details);
                  redraw();
                },
                onScaleEnd: (details) {
                  manager.onScaleEnd(details);
                  redraw();
                },
                onTapDown: (details) {
                  manager.onTapDown(details);
                  redraw();
                },
              ),
              Container(
                height: 40,
              ),
            ],
          );
        });
  }
}
