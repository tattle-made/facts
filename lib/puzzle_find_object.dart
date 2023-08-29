import 'package:facts/image_forensic_pan_draw.dart';
import 'package:flutter/material.dart';

class PuzzleFindObject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PuzzleFindObject> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Color.fromARGB(255, 201, 203, 163),
        child: ImageForensicPandDraw());
  }
}
