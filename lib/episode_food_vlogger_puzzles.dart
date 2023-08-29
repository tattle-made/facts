import 'dart:ui';

import 'package:facts/image_forensic_region.dart';
import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/material.dart';

class EpisodeFoodVloggerPuzzles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<EpisodeFoodVloggerPuzzles> {
  Region region = Region(Offset(0, 0), Size(0, 0));

  void onRegionChange(Region r) {
    setState(() {
      region = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Puzzle Page',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
        SizedBox(
          width: 240,
          height: 240,
          child: Stack(
            children: [
              ImageForensicRegion(
                onChange: onRegionChange,
              ),
              CustomPaint(painter: Painter(region))
            ],
          ),
        ),
        Text('Region $region')
      ],
    );
  }
}

class Painter extends CustomPainter {
  Region region;

  Painter(this.region);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(region.origin.dx, region.origin.dy, region.dim.width,
            region.dim.height),
        Paint()
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..color = Color.fromARGB(255, 255, 225, 168));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
