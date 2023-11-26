import 'dart:io';

import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/widget/layer_compositor.dart';
import 'package:image_compare/image_compare.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

Future<bool> compare(PlayerLabCanvas targetImage, double w, double h,
    PlayerLabCanvas artboard, Function onChange) async {
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
  var canvas = ui.Canvas(recorder);

  draw(canvas, Size(w, h), artboard, artboard.brushMask.imageBrushMask);

  var picture = recorder.endRecording();
  ui.Image image = await picture.toImage(w.toInt(), h.toInt());
  final ByteData? pngBytes =
      await image.toByteData(format: ui.ImageByteFormat.png);
  var uInt8ListViewOverB = pngBytes!.buffer.asUint8List();

  var recorder2 = ui.PictureRecorder();
  var canvas2 = ui.Canvas(recorder2);

  draw(canvas2, Size(w, h), targetImage, targetImage.brushMask.imageBrushMask);

  var picture2 = recorder2.endRecording();
  ui.Image image2 = await picture2.toImage(w.toInt(), h.toInt());
  final ByteData? pngBytes2 =
      await image2.toByteData(format: ui.ImageByteFormat.png);
  var uInt8ListViewOverB2 = pngBytes2!.buffer.asUint8List();

  Directory saveDir = await getApplicationDocumentsDirectory();
  File saveFile = File('${saveDir.path}/test2.png');

  print(saveFile.toString());

  if (!saveFile.existsSync()) {
    saveFile.createSync(recursive: true);
  }
  saveFile.writeAsBytesSync(pngBytes.buffer.asUint8List(), flush: true);

  var result = await compareImages(
      src1: uInt8ListViewOverB,
      src2: uInt8ListViewOverB2,
      algorithm: PixelMatching());

  print("result : $result");

  onChange(saveFile);

  return true;
}
