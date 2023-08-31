import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageForensicLens extends StatefulWidget {
  final Function? onSlide;
  const ImageForensicLens({super.key, this.onSlide});

  @override
  State<ImageForensicLens> createState() => _ImageForensicLensState();
}

class _ImageForensicLensState extends State<ImageForensicLens> {
  late Timer timer;
  double pixelSize = 0;
  double pixelSize2 = 0;
  double increment = 10;
  FragmentShader? shader;
  ui.Image? image;
  ui.Image? image2;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/snapchat_01.jpg');
    image = await decodeImageFromList(imageData.buffer.asUint8List());
    final imageData2 = await rootBundle.load('assets/snapchat_02.jpg');
    image2 = await decodeImageFromList(imageData2.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/shader_pixel.frag');
    shader = program.fragmentShader();
    setState(() {
      // trigger a repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // setState(() {
      //   pixelSize += increment;
      //   if (pixelSize == 450 || pixelSize == 0) {
      //     increment *= -1;
      //     pixelSize += increment;
      //   }
      // });
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyShader();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Stack(
        children: [
          SizedBox(
            width: 400.0,
            height: 400.0,
            child: GestureDetector(
              child: CustomPaint(
                  painter: PixelationShaderPainter(
                      shader!, pixelSize, pixelSize2, image!, image2!)),
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
