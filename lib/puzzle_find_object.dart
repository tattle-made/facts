import 'package:facts/episode_food_vlogger.dart';
import 'package:facts/image_forensic_pan_draw.dart';
import 'package:facts/image_forensic_slider.dart';
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
    return ImageForensicPandDraw();
  }
}
