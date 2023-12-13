import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:facts/player_lab/widget/drawn_path.dart';
import 'package:facts/player_lab/widget/layer_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArtBoard extends StatefulWidget {
  late PlayerLabCanvas playerCanvas;
  Function? onChange;

  ArtBoard({super.key, required this.playerCanvas, required this.onChange});

  @override
  State<ArtBoard> createState() => _ArtBoardState();
}

class _ArtBoardState extends State<ArtBoard> {
  ui.Image? imageBrushMask;
  var paths = DrawnPath();

  Future<void> _regenerateImage() async {
    imageBrushMask = await makeImageFromPath(paths);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _regenerateImage();
  }

  @override
  Widget build(BuildContext context) {
    return imageBrushMask != null
        ? Column(
            children: [
              GestureDetector(
                child: SizedBox(
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
                        painter: Compositor(
                            playerLab: widget.playerCanvas,
                            tex2: imageBrushMask),
                      ),
                    ),
                  ),
                ),
                onPanStart: (details) {
                  // print("pan down ${details.localPosition}");
                  paths.initializeNewPath();
                  paths.setDimension(MediaQuery.of(context).size.width.floor(),
                      (170 / 297 * MediaQuery.of(context).size.width).floor());
                },
                onPanEnd: (details) {
                  // print("pan up");
                  for (var path in paths.paths) {
                    // print("${paths.canvasWidth}, ${paths.canvasHeight}");
                    // print(path);
                  }
                },
                onPanUpdate: (details) {
                  // print("pan update : ${details.localPosition}");

                  paths.addToLast(details.localPosition);
                  _regenerateImage();
                },
              ),
              LayerControls(
                  controls: widget.playerCanvas
                      .layers![widget.playerCanvas.selectionIndex].controls,
                  onChange: widget.onChange)
            ],
          )
        : Text('Loading');
  }
}

class Compositor extends CustomPainter {
  PlayerLabCanvas? playerLab;
  ui.Image? tex2;

  Compositor({this.playerLab, this.tex2});

  draw(Canvas canvas, Size size, PlayerLabCanvas playerLab, ui.Image tex2) {
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
        image.shader?.setFloat(0, size.width);
        image.shader?.setFloat(1, size.height);
        for (var i = 0; i < layer.controls.length; i++) {
          if (layer.controls[i].runtimeType == ControlValueDoubleRange) {
            image.shader?.setFloat(2 + i, layer.controls[i].value);
          }
        }
        image.shader?.setImageSampler(0, image!.image!);
        // if (tex2 != null) {
        //   image.shader?.setImageSampler(1, tex2!);
        // }
        paint.shader = image!.shader;
        canvas.drawRect(Offset.zero & size, paint);
      } else {
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
      //   double width = (currentLayer.image!.image!.width) * 1.0;
      //   double height = (currentLayer.image!.image!.height) * 1.0;
      //
      //   canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
      // }

      canvas.restore();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    draw(canvas, size, playerLab!, tex2!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Future<ui.Image> makeImageFromPath(DrawnPath drawnPath) async {
  var paths = drawnPath.paths;
  const width = 64;
  const height = 64;
  const bytesPerPixel = 4;
  final buffer = Uint8List(width * height * bytesPerPixel);
  for (int y = 0; y < width; y++) {
    for (int x = 0; x < height; x++) {
      final offset = ((y * width) + x) * bytesPerPixel;
      buffer[offset] = 255;
      buffer[offset + 1] = 255;
      buffer[offset + 2] = 255;
    }
  }
  for (var path in paths) {
    for (var point in path) {
      var x = ((point.dx * width) / drawnPath.canvasWidth);
      var y = ((point.dy * height) / drawnPath.canvasHeight);

      // for (var i=-3;i<3;i++){
      //   // final offset = (((y.toInt()) * width + (x.toInt()) ) * (bytesPerPixel)).clamp(0, width*height);
      //   final offset = ((y.toInt() * width + x.toInt()) * (i*bytesPerPixel)).clamp(0, width*height);
      //   buffer[offset] -= 25;
      // }
      final offset =
          ((y.toInt()) * width + (x.toInt())).clamp(0, width * height - 2) *
              bytesPerPixel;
      buffer[offset] -= 25;
    }
  }

  final immutable = await ui.ImmutableBuffer.fromUint8List(buffer);
  final descriptor = ui.ImageDescriptor.raw(
    immutable,
    width: width,
    height: height,
    pixelFormat: ui.PixelFormat.rgba8888,
  );
  final codec = await descriptor.instantiateCodec(
    targetWidth: width,
    targetHeight: height,
  );
  final frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}
