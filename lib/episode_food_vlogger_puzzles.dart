import 'package:facts/image_forensic_slider.dart';
import 'package:flutter/material.dart';

class EpisodeFoodVloggerPuzzles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<EpisodeFoodVloggerPuzzles> {
  double sliderX = 0;
  double sliderY = 0;

  void onSlide(double x, double y) {
    print('sliding $x : $y');
    setState(() {
      sliderX = x;
      sliderY = y;
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
              ImageForensicSlider(
                onSlide: onSlide,
              ),
              CustomPaint(painter: Painter(sliderX))
            ],
          ),
        )
      ],
    );
  }
}

class Painter extends CustomPainter {
  double sliderX = 0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(sliderX, 0, 10, 240),
        Paint()..color = Color.fromARGB(255, 255, 225, 168));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Painter(this.sliderX);
}
