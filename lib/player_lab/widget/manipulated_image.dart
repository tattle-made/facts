import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import '../model/canvas.dart';

class ManipulatedImage extends StatefulWidget {
  PlayerLabCanvas? playerLab;
  ui.Image? tex2;

  ManipulatedImage({super.key, this.playerLab, this.tex2});

  @override
  State<ManipulatedImage> createState() => _ManipulatedImageState();
}

class _ManipulatedImageState extends State<ManipulatedImage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
