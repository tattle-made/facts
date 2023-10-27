import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PuzzlePandAndDraw extends StatefulWidget {
  final Function? onChange;
  final Function? onPuzzleDone;
  const PuzzlePandAndDraw({super.key, this.onChange, this.onPuzzleDone});

  @override
  State<PuzzlePandAndDraw> createState() => _PuzzlePandAndDrawState();
}

class _PuzzlePandAndDrawState extends State<PuzzlePandAndDraw> {
  FragmentShader? shader;
  ui.Image? image;
  Offset start = Offset(0, 0);
  Offset current = Offset(0, 0);
  bool shouldPan = true;
  double offset = 0;
  Region region = Region(const Offset(0, 0), const Size(0, 0));
  bool showInstructions = true;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/pannable_pantry_2.png');
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/shader_pan.frag');
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
      return Column(
        children: [
          Container(
              color: Color.fromARGB(255, 201, 203, 163),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 4 / 5 * MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          child: CustomPaint(
                              painter: PixelationShaderPainter(
                                  shader!, image!, offset!)),
                        ),
                        onPanUpdate: (details) {
                          var position = details.localPosition;
                          if (shouldPan) {
                            current = Offset(position.dx, position.dy);
                            Offset delta = start - current;
                            setState(() {
                              offset = delta.dx;
                            });
                          } else {
                            setState(() {
                              region.dim = Size(position.dx - region.origin.dx,
                                  position.dy - region.origin.dy);
                            });
                            widget.onChange?.call(region);
                          }
                        },
                        onPanDown: (details) {
                          var position = details.localPosition;
                          if (shouldPan) {
                            start = Offset(position.dx, position.dy);
                          } else {
                            setState(() {
                              region.origin = Offset(position.dx, position.dy);
                              region.dim = Size(0, 0);
                            });
                            widget.onChange?.call(region);
                          }
                        },
                        onPanEnd: (details) {
                          // start = current;
                        },
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: RegionPainter(region),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    shouldPan = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 225, 168),
                                      border: Border.all(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                  child: Icon(
                                    Icons.aspect_ratio_outlined,
                                    color: shouldPan
                                        ? Color.fromARGB(255, 114, 61, 70)
                                        : Color.fromARGB(255, 226, 109, 92),
                                    size: 48.0,
                                    semanticLabel: 'Draw Rectangle',
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  region = Region.origin();
                                  shouldPan = true;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 225, 168),
                                    border: Border.all(
                                        color: Color.fromARGB(255, 255, 0, 0),
                                        width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Icon(
                                  Icons.pan_tool_outlined,
                                  color: shouldPan
                                      ? Color.fromARGB(255, 226, 109, 92)
                                      : Color.fromARGB(255, 114, 61, 70),
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
                              Heading('Train your Eyes!'),
                              Paragraph(
                                  'The very first skill you need is the ability to closely observe images and look for details \n'),
                              Paragraph(
                                  "A sharp detective should be able to find Needle in a haystack. Your first task is much simpler. Can you find the ketchup bottle in Ms Masoorie’s Pantry?"),
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
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        color: Color.fromARGB(255, 226, 109, 92),
                        child: Text("Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 24.0,
                                color: Color.fromARGB(255, 255, 225, 168))),
                      ),
                    )
                  ],
                )
              : Container()
        ],
      );
    }
  }
}

class PixelationShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final ui.Image? image;
  final double offset;

  PixelationShaderPainter(
      FragmentShader fragmentShader, this.image, this.offset)
      : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, offset / (1 * size.width));
    // shader.setFloat(2, pixelSize);
    // shader.setFloat(3, pixelSize2);
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

var paraStyle = GoogleFonts.raleway(
    textStyle: TextStyle(
        color: Color.fromARGB(255, 71, 45, 48),
        fontSize: 16.0,
        height: 1.2,
        fontWeight: FontWeight.w600));

var headingStyle = GoogleFonts.pressStart2p(
    textStyle:
        TextStyle(color: Color.fromARGB(255, 71, 45, 48), fontSize: 60.0));
