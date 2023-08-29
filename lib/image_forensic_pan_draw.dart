import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageForensicPandDraw extends StatefulWidget {
  final Function? onChange;
  const ImageForensicPandDraw({super.key, this.onChange});

  @override
  State<ImageForensicPandDraw> createState() => _ImageForensicPandDrawState();
}

class _ImageForensicPandDrawState extends State<ImageForensicPandDraw> {
  FragmentShader? shader;
  ui.Image? image;
  Offset start = Offset(0, 0);
  Offset current = Offset(0, 0);
  bool shouldPan = true;
  double offset = 0;
  Region region = Region(const Offset(0, 0), const Size(0, 0));

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

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
          color: Color.fromARGB(255, 201, 203, 163),
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: GestureDetector(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
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
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: Color.fromARGB(250, 255, 225, 168),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              shouldPan = !shouldPan;
                            });
                          },
                          child: Icon(
                            Icons.aspect_ratio_outlined,
                            color: Color.fromARGB(255, 226, 109, 92),
                            size: 48.0,
                            semanticLabel: 'Draw Rectangle',
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ));
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

  @override
  String toString() {
    return 'Region{offset: (${origin.dx}, ${origin.dy}) dim: (${dim.width},${dim.height})';
  }
}
