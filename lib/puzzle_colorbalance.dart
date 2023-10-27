import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PuzzleColorBalance extends StatefulWidget {
  final Function? onSlide;
  final Function? onPuzzleDone;
  const PuzzleColorBalance({super.key, this.onSlide, this.onPuzzleDone});

  @override
  State<PuzzleColorBalance> createState() => _PuzzleColorBalanceState();
}

class _PuzzleColorBalanceState extends State<PuzzleColorBalance> {
  FragmentShader? shader;
  ui.Image? image;
  Offset origin = Offset(100, 100);
  bool allowDrag = false;
  bool showInstructions = true;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/capsicum.png');
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    var program =
        await FragmentProgram.fromAsset('shaders/shader_whitebalance.frag');
    shader = program.fragmentShader();
    setState(() {
      // trigger a repaint
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyShader();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showTask() {
    setState(() {
      showInstructions = true;
    });
  }

  void hideTask() {
    setState(() {
      showInstructions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: const Color.fromARGB(255, 201, 203, 163),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 4 / 5 * MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: GestureDetector(
                        child: CustomPaint(
                            painter: PixelationShaderPainter(
                                shader!, image!, origin!)),
                        onPanUpdate: (details) {
                          if (allowDrag) {
                            var position = details.localPosition;
                            setState(() {
                              origin = Offset(position.dx, position.dy);
                            });
                          }
                        },
                        onPanDown: (details) {
                          if (allowDrag) {
                            var position = details.localPosition;
                            setState(() {
                              origin = Offset(position.dx, position.dy);
                            });
                          }
                        },
                      ),
                    ),
                    CustomPaint(
                      painter: RegionPainter(origin, allowDrag),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    allowDrag = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 225, 168),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0))),
                                  child: const Icon(
                                    Icons.open_with_outlined,
                                    color: Color.fromARGB(255, 114, 61, 70),
                                    size: 48.0,
                                    semanticLabel: 'Draw Rectangle',
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    showInstructions
                        ? SingleChildScrollView(
                            child: Container(
                            color: Color.fromARGB(255, 201, 203, 163),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Heading('Balancing Act'),
                                Paragraph(
                                    'If you have ever used water colors as a child, you know how colors can be combined to form different colors. \n\nDigital images are composed of 3 color channels - Red, Green and Blue. Changing the balance of these can change how we percieve the content of the image. \n '),
                                Paragraph(
                                    "The internet is interested to know the colors of the capsicum Masoori used. Seems to be hard given the quality of the image. Give it a try"),
                                Button(label: "Next", onClick: hideTask)
                              ],
                            ),
                          ))
                        : Container(),
                  ],
                )),
            !showInstructions
                ? Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            widget?.onPuzzleDone?.call();
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Colors',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                color: const Color.fromARGB(255, 226, 109, 92),
                                child: const Text("Submit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 24.0,
                                        color: Color.fromARGB(
                                            255, 255, 225, 168))),
                              ),
                            ],
                          ))
                    ],
                  )
                : Column()
          ],
        ),
      );
    }
  }
}

class PixelationShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final ui.Image? image;
  final Offset origin;

  PixelationShaderPainter(
      FragmentShader fragmentShader, this.image, this.origin)
      : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, origin.dx!);
    shader.setFloat(3, origin.dy!);
    shader.setImageSampler(0, image!);

    final paint = Paint();

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RegionPainter extends CustomPainter {
  Offset origin;
  bool allowDrag;

  RegionPainter(this.origin, this.allowDrag);

  @override
  void paint(Canvas canvas, Size size) {
    if (allowDrag) {
      var linePaint = Paint()
        ..strokeWidth = 8.0
        ..style = PaintingStyle.stroke
        ..color = Color.fromARGB(255, 226, 109, 92);
      canvas.drawLine(origin, origin + Offset(50, 0), linePaint);
      canvas.drawLine(
          origin + Offset(25, -25), origin + Offset(25, 25), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Future<Image> tinypng() async {
//   final bytes = Uint8List.fromList([
//     137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0,
//     1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10, 73, 68, 65,
//     84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0, 0, 0, 0, 73,
//     69, 78, 68, 174, 66, 96, 130 // prevent dartfmt
//   ]);
//
//   // copy from decodeImageFromList of package:flutter/painting.dart
//   final codec = await instantiateImageCodec(bytes);
//   final frameInfo = await codec.getNextFrame();
//   return frameInfo.image;
// }
