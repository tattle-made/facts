import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageForensicPandDraw extends StatefulWidget {
  final Function? onSlide;
  const ImageForensicPandDraw({super.key, this.onSlide});

  @override
  State<ImageForensicPandDraw> createState() => _ImageForensicPandDrawState();
}

class _ImageForensicPandDrawState extends State<ImageForensicPandDraw> {
  double pixelSize = 0;
  double pixelSize2 = 0;
  double increment = 10;
  FragmentShader? shader;
  ui.Image? image;
  ui.Image? image2;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/size_01.png');
    image = await decodeImageFromList(imageData.buffer.asUint8List());
    final imageData2 = await rootBundle.load('assets/size_01.png');
    image2 = await decodeImageFromList(imageData2.buffer.asUint8List());

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
        height: MediaQuery.of(context).size.height - 200.0,
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              child: CustomPaint(
                  painter: PixelationShaderPainter(
                      shader!, pixelSize, pixelSize2, image!, image2!)),
            ),
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
    // shader.setFloat(0, size.width);
    // shader.setFloat(1, size.height);
    // shader.setFloat(2, pixelSize);
    // shader.setFloat(3, pixelSize2);
    // shader.setImageSampler(0, image!);

    final paint = Paint();

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
