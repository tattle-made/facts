import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:facts/player_lab/widget/drawn_path.dart';

class Mask {
  late ui.Image imageBrushMask;
  var drawnPath = DrawnPath() ;

  Future<ui.Image> makeImageFromPath() async {
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
    for(var path in paths){
      for(var point in path){
        var x = ((point.dx * width)/drawnPath.canvasWidth);
        var y = ((point.dy * height)/drawnPath.canvasHeight);

        // for (var i=-3;i<3;i++){
        //   // final offset = (((y.toInt()) * width + (x.toInt()) ) * (bytesPerPixel)).clamp(0, width*height);
        //   final offset = ((y.toInt() * width + x.toInt()) * (i*bytesPerPixel)).clamp(0, width*height);
        //   buffer[offset] -= 25;
        // }
        final offset = ((y.toInt()) * width + (x.toInt()) ).clamp(0, width*height-2)* bytesPerPixel;
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
    imageBrushMask = frameInfo.image;
    return imageBrushMask;
  }

  Future<void> makeWhiteImage() async {
    const width = 64;
    const height = 64;
    const bytesPerPixel = 4;
    final buffer = Uint8List(width * height * bytesPerPixel);
    for (int y = 0; y < width; y++) {
      for (int x = 0; x < height; x++) {
        if(x==y){
          final offset = ((y * width) + x) * bytesPerPixel;
          buffer[offset] = 0;
          buffer[offset + 1] = 0;
          buffer[offset + 2] = 0;
        }else {
          final offset = ((y * width) + x) * bytesPerPixel;
          buffer[offset] = 255;
          buffer[offset + 1] = 255;
          buffer[offset + 2] = 255;
        }
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
    imageBrushMask = frameInfo.image;
  }
}