import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:image_compare/image_compare.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

Future<bool> compare(PlayerLabCanvas targetImage, double w, double h,
    PlayerLabCanvas artboard) async {
  // var targetImageData = await rootBundle.load(targetImage);
  //
  // var tmpImage = "http://localhost:9000/p1_target.png";
  // var artboardImageData = Uri.parse(tmpImage);
  //
  // var result = await compareImages(
  //     src1: artboardImageData,
  //     src2: artboardImageData,
  //     algorithm: PerceptualHash());
  //

  print('clicked $w $h');
  var recorder = ui.PictureRecorder();
  var canvas =
      ui.Canvas(recorder, Rect.fromPoints(Offset(0.0, 0.0), Offset(w, h)));

  for (var i = 0; i < artboard!.layers!.length; i++) {
    canvas.save();
    PlayerLabLayer layer = artboard!.layers![i];
    canvas.translate(layer.location!.dx, layer.location!.dy);
    canvas.scale(layer.zoom!);
    canvas.drawImage(layer!.image!.image!, Offset.zero, ui.Paint());
    canvas.restore();
  }

  var picture = recorder.endRecording();
  ui.Image image = await picture.toImage(411, 235);
  final ByteData? pngBytes =
      await image.toByteData(format: ui.ImageByteFormat.png);
  var uInt8ListViewOverB = pngBytes!.buffer.asUint8List();

  var recorder2 = ui.PictureRecorder();
  var canvas2 =
      ui.Canvas(recorder2, Rect.fromPoints(Offset(0.0, 0.0), Offset(w, h)));

  canvas2.save();
  PlayerLabLayer layer = targetImage!.layers![0];
  canvas2.translate(layer.location!.dx, layer.location!.dy);
  canvas2.scale(layer.zoom!);
  canvas2.drawImage(layer!.image!.image!, Offset.zero, ui.Paint());
  canvas2.restore();

  var picture2 = recorder2.endRecording();
  ui.Image image2 = await picture2.toImage(411, 235);
  final ByteData? pngBytes2 =
      await image2.toByteData(format: ui.ImageByteFormat.png);
  var uInt8ListViewOverB2 = pngBytes2!.buffer.asUint8List();

  var result = await compareImages(
      src1: uInt8ListViewOverB,
      src2: uInt8ListViewOverB2,
      algorithm: PerceptualHash());

  print("result : $result");

  return true;
}
