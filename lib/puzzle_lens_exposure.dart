import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:facts/atoms/button.dart';
import 'package:facts/atoms/heading.dart';
import 'package:facts/atoms/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PuzzleLensExposure extends StatefulWidget {
  final Function? onSlide;
  final Function? onPuzzleDone;
  const PuzzleLensExposure({super.key, this.onSlide, this.onPuzzleDone});

  @override
  State<PuzzleLensExposure> createState() => _PuzzleLensExposureState();
}

class _PuzzleLensExposureState extends State<PuzzleLensExposure> {
  double pixelSize = 0;
  double pixelSize2 = 0;
  double increment = 10;
  FragmentShader? shader;
  ui.Image? image;
  ui.Image? image2;
  bool showInstructions = true;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/microwave_01.png');
    image = await decodeImageFromList(imageData.buffer.asUint8List());
    final imageData2 = await rootBundle.load('assets/microwave_02.png');
    image2 = await decodeImageFromList(imageData2.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/shader_lens.frag');
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
                            painter: PixelationShaderPainter(shader!, pixelSize,
                                pixelSize2, image!, image2!)),
                        onPanUpdate: (details) {
                          var position = details.globalPosition;
                          setState(() {
                            pixelSize = position.dx;
                            pixelSize2 = position.dy;
                          });
                          widget.onSlide?.call(position.dx, position.dy);
                        },
                      ),
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
                                    Icons.search_outlined,
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
                                Heading('Lighten \nUp!'),
                                Paragraph(
                                    "Exposure is the amount of light that reaches your camera’s sensor, creating the image over a period of time. That time period could be fractions of a second or entire hours. Our eyes perceive change in exposure as change in the brightness of an image. \n"),
                                Paragraph(
                                    "\nPeople often change the exposure of an image to make it dark and hide certain details\n"),
                                Paragraph(
                                    "There is a picture of Ms Masoorie’s kitchen that is going viral claiming that a ghost can be seen in her microwave. Many people believe it's what killed her. Could you shed some light on it?"),
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
                                    labelText: 'What is it?',
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
                : Container()
          ],
        ),
      );
    }
  }
}

class PixelationShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double pixelSize;
  final double pixelSize2;
  final ui.Image? image;
  final ui.Image? image2;

  PixelationShaderPainter(FragmentShader fragmentShader, this.pixelSize,
      this.pixelSize2, this.image, this.image2)
      : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, pixelSize);
    shader.setFloat(3, pixelSize2);
    shader.setImageSampler(0, image!);
    shader.setImageSampler(1, image2!);

    final paint = Paint();

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
