import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PuzzleLensELA extends StatefulWidget {
  final Function? onSlide;
  final Function? onPuzzleDone;
  const PuzzleLensELA({super.key, this.onSlide, this.onPuzzleDone});

  @override
  State<PuzzleLensELA> createState() => _PuzzleLensELAState();
}

class _PuzzleLensELAState extends State<PuzzleLensELA> {
  FragmentShader? shader;
  ui.Image? image;
  Region region = Region(const Offset(0, 0), const Size(0, 0));
  bool showInstructions = true;

  void loadMyShader() async {
    final imageData =
        await rootBundle.load('assets/wine_bottle_manipulated.png');
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/shader_image.frag');
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
                            painter: PixelationShaderPainter(shader!, image!)),
                        onPanUpdate: (details) {
                          var position = details.localPosition;
                          setState(() {
                            region.dim = Size(position.dx - region.origin.dx,
                                position.dy - region.origin.dy);
                          });
                        },
                        onPanDown: (details) {
                          var position = details.localPosition;
                          setState(() {
                            region.origin = Offset(position.dx, position.dy);
                            region.dim = Size(0, 0);
                          });
                        },
                      ),
                    ),
                    CustomPaint(
                      painter: RegionPainter(region),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
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
                                    Icons.aspect_ratio_outlined,
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
                        ? Container(
                            color: Color.fromARGB(255, 201, 203, 163),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Heading('Drinking on the\nJob'),
                                Paragraph(
                                    "People are circulating manipulated images of her kitchen to prove that she was drunk while cooking.\n Look for visual clues in the image and find if this claim is correct"),
                                Button(label: "Next", onClick: hideTask)
                              ],
                            ),
                          )
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
                : Container()
          ],
        ),
      );
    }
  }
}

class PixelationShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final ui.Image? image;

  PixelationShaderPainter(FragmentShader fragmentShader, this.image)
      : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setImageSampler(0, image!);

    final paint = Paint();

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Region {
  Offset origin = const Offset(0, 0);
  Size dim = const Size(0, 0);

  Region(this.origin, this.dim);

  factory Region.origin() {
    return Region(Offset(0, 0), Size(0, 0));
  }

  @override
  String toString() {
    return 'Region{offset: (${origin.dx}, ${origin.dy}) dim: (${dim.width},${dim.height})';
  }
}

class RegionPainter extends CustomPainter {
  Region region;

  RegionPainter(this.region);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(region.origin.dx, region.origin.dy, region.dim.width,
            region.dim.height),
        Paint()
          ..strokeWidth = 8.0
          ..style = PaintingStyle.stroke
          ..color = Color.fromARGB(255, 226, 109, 92));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
