import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/canvas.dart';
import '../model/layer.dart';
import '../model/layer_config.dart';

class LayerCompositor extends CustomPainter {
  PlayerLabCanvas playerLab;
  ui.Image imageMask;

  LayerCompositor({required this.playerLab, required this.imageMask});

  draw(Canvas canvas, Size size, PlayerLabCanvas playerLab, ui.Image imageMask){
    var paint = Paint();
    paint.color = Color.fromARGB(255, 42, 20, 27);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    for (var i = 0; i < playerLab!.layers!.length; i++) {
      canvas.save();
      PlayerLabLayer layer = playerLab!.layers![i];
      canvas.translate(layer.location!.dx, layer.location!.dy);
      canvas.scale(layer.zoom!);

      var paint = Paint();
      if(layer.image!.shader!=null){
        var image = layer.image!;
        image.shader?.setFloat(0, size.width);
        image.shader?.setFloat(1, size.height);
        for(var i=0;i<layer.controls.length;i++){
          if(layer.controls[i].runtimeType==ControlValueDoubleRange){
            image.shader?.setFloat(2+i, layer.controls[i].value);
          }
        }
        image.shader?.setImageSampler(0, image!.image!);
        image.shader?.setImageSampler(1, imageMask);
        paint.shader = image!.shader;
        canvas.drawRect(Offset.zero & size, paint);
      }else{
        canvas.drawImage(layer!.image!.image!, Offset.zero, paint);
      }

      // draw selection
      // if (i == playerLab!.selectionIndex) {
      //   var paint = Paint();
      //   paint.color = Colors.green;
      //   paint.strokeWidth = 2;
      //   paint.style = PaintingStyle.stroke;
      //
      //   var currentLayer = playerLab!.layers![i];
      //
      //   double width = currentLayer.image!.image!.width.toDouble();
      //   double height = currentLayer.image!.image!.height.toDouble();
      //
      //   canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
      // }

      canvas.restore();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    draw(canvas, size, playerLab, imageMask);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}