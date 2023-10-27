import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Artboard extends StatelessWidget {
  PlayerLabCanvas playerCanvas;

  Artboard({super.key, required this.playerCanvas});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 170 / 297 * MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 178, 43, 42),
                    spreadRadius: 4.0,
                    blurRadius: 6.2),
                BoxShadow(color: Colors.red, spreadRadius: 1.0),
              ],
              backgroundBlendMode: BlendMode.colorBurn),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CustomPaint(
              painter: Compositor(playerLab: playerCanvas),
            ),
          ),
        ));
  }
}

class Compositor extends CustomPainter {
  PlayerLabCanvas? playerLab;
  Compositor({this.playerLab});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color.fromARGB(255, 42, 20, 27);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    for (var i = 0; i < playerLab!.layers!.length; i++) {
      canvas.save();
      PlayerLabLayer layer = playerLab!.layers![i];
      canvas.translate(layer.location!.dx, layer.location!.dy);
      canvas.scale(layer.zoom!);
      canvas.drawImage(layer!.image!.image!, Offset.zero, Paint());

      // draw selection
      // if (i == playerLab!.selectionIndex) {
      //   var paint = Paint();
      //   paint.color = Colors.green;
      //   paint.strokeWidth = 2;
      //   paint.style = PaintingStyle.stroke;
      //
      //   var currentLayer = playerLab!.layers![i];
      //
      //   double width = (currentLayer.image!.image!.width) * 1.0;
      //   double height = (currentLayer.image!.image!.height) * 1.0;
      //
      //   canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
      // }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}