import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageForensicRegion extends StatefulWidget {
  final Function? onChange;
  const ImageForensicRegion({super.key, this.onChange});

  @override
  State<ImageForensicRegion> createState() => _ImageForensicRegionState();
}

class _ImageForensicRegionState extends State<ImageForensicRegion> {
  late Timer timer;
  Region region = Region(const Offset(0, 0), const Size(0, 0));
  double increment = 10;
  FragmentShader? shader;
  ui.Image? image;

  void loadMyShader() async {
    final imageData = await rootBundle.load('assets/snapchat_01.jpg');
    image = await decodeImageFromList(imageData.buffer.asUint8List());

    var program = await FragmentProgram.fromAsset('shaders/shader_region.frag');
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
                  painter: PixelationShaderPainter(shader!, region, image!)),
              onPanDown: (details) {
                var position = details.localPosition;
                setState(() {
                  region.origin = Offset(position.dx, position.dy);
                  region.dim = Size(0, 0);
                });
                widget.onChange?.call(region);
              },
              onPanUpdate: (details) {
                var position = details.localPosition;
                setState(() {
                  region.dim = Size(position.dx - region.origin.dx,
                      position.dy - region.origin.dy);
                });
                widget.onChange?.call(region);
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
  final Region region;
  final ui.Image? image;

  PixelationShaderPainter(
      FragmentShader fragmentShader, this.region, this.image)
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

  @override
  String toString() {
    return 'Region{offset: (${origin.dx}, ${origin.dy}) dim: (${dim.width},${dim.height})';
  }
}
