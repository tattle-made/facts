import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageForensicSlider extends StatefulWidget {
  final Function? onSlide;
  String imagePath1 = "assets/snapchat_01.jpg";
  String imagePath2 = "assets/snapchat_02.jpg";
  ImageForensicSlider(
      {super.key,
      this.onSlide,
      required this.imagePath1,
      required this.imagePath2});

  @override
  State<ImageForensicSlider> createState() => _ImageForensicSliderState();
}

class _ImageForensicSliderState extends State<ImageForensicSlider> {
  double pixelSize = 200;
  double pixelSize2 = 0;
  double increment = 10;
  FragmentShader? shader;
  ui.Image? image;
  ui.Image? image2;

  void loadMyShader() async {
    final imageData = await rootBundle.load(widget.imagePath1);
    image = await decodeImageFromList(imageData.buffer.asUint8List());
    final imageData2 = await rootBundle.load(widget.imagePath2);
    image2 = await decodeImageFromList(imageData2.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/shader_pixel.frag');
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
      return Column(
        children: [
          Container(
            color: Color.fromARGB(255, 201, 203, 163),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 1 / 2 * MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: GestureDetector(
                      child: CustomPaint(
                          painter: PixelationShaderPainter(
                              shader!, pixelSize, pixelSize2, image!, image2!)),
                      onPanUpdate: (details) {
                        var position = details.localPosition;
                        setState(() {
                          pixelSize = position.dx;
                          pixelSize2 = position.dy;
                        });
                        widget.onSlide?.call(position.dx, position.dy);
                      },
                    ),
                  ),
                ),
                CustomPaint(
                  painter: SliderHandle(pixelSize),
                )
              ],
            ),
          )
        ],
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

class SliderHandle extends CustomPainter {
  double sliderLocation;

  SliderHandle(this.sliderLocation);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 226, 109, 92);
    canvas.drawLine(
        Offset(sliderLocation, 0), Offset(sliderLocation, size.height), paint);
    // canvas.drawRect(Rect.fromLTWH(0, 0, 200, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
