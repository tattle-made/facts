import 'dart:ui' as ui;
import 'package:facts/atoms/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/canvas.dart';
import '../model/layer.dart';
import '../model/layer_config.dart';

void draw(
    Canvas canvas, Size size, PlayerLabCanvas playerLab, ui.Image imageMask) {
  var paint = Paint();
  paint.color = Color.fromARGB(255, 42, 20, 27);
  canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

  for (var i = 0; i < playerLab!.layers!.length; i++) {
    canvas.save();
    PlayerLabLayer layer = playerLab!.layers![i];
    canvas.translate(layer.location!.dx, layer.location!.dy);
    canvas.scale(layer.zoom!);

    var paint = Paint();
    if (layer.image!.shader != null) {
      var image = layer.image!;
      double width = image!.image!.width.toDouble();
      double height = image!.image!.height.toDouble();

      image.shader?.setFloat(0, width);
      image.shader?.setFloat(1, height);
      for (var i = 0; i < layer.controls.length; i++) {
        if (layer.controls[i].runtimeType == ControlValueDoubleRange) {
          image.shader?.setFloat(2 + i, layer.controls[i].value);
        }
      }
      image.shader?.setImageSampler(0, image!.image!);
      if (playerLab.usesBrush) {
        image.shader?.setImageSampler(1, imageMask);
      }
      paint.shader = image!.shader;

      canvas.drawRect(Offset.zero & Size(width, height), paint);

      //draw selection bound
      // if (i == playerLab!.selectionIndex) {
      //   var selectionPaint = Paint();
      //   selectionPaint.color = primary;
      //   selectionPaint.strokeWidth = 4;
      //   selectionPaint.style = PaintingStyle.stroke;
      //   canvas.drawRect(Offset.zero & Size(width, height), selectionPaint);
      // }
    }
    // else {
    //   canvas.drawImage(layer!.image!.image!, Offset.zero, paint);
    // }

    canvas.restore();
  }
}

class LayerCompositor extends CustomPainter {
  PlayerLabCanvas playerLab;

  LayerCompositor({required this.playerLab});

  @override
  void paint(Canvas canvas, Size size) {
    draw(canvas, size, playerLab, playerLab.brushMask.imageBrushMask);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
