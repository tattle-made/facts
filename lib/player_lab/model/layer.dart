import 'dart:ui';
import 'dart:math';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer_config.dart';

class PlayerLabLayer {
  PlayerLabImage? image;
  late List<ControlValueType> controls;
  List<Point>? path;
  Offset location;
  double zoom;

  Offset locationPanStart = Offset.zero;
  Offset panStart = Offset.zero;
  Offset panDelta = Offset.zero;

  double zoomStart = 0.0;

  bool allowZoom;
  bool allowPan;
  bool allowBrush;

  PlayerLabLayer(
      {this.image,
      this.zoom = 1.0,
      this.path,
      this.location = Offset.zero,
      required this.controls,
      this.allowZoom = true,
      this.allowPan = true,
      this.allowBrush = false});

  @override
  String toString() {
    // return "Location : $location}\nScale2Start: $panStart}, PanDelta:$panDelta";
    return "Zoom : $zoom, ZoomStart: $zoomStart";
  }

  double updateZoom(double newZoom) {
    if (allowZoom!) {
      if (newZoom > 2.5) {
        return 2.5;
      } else if (newZoom < 0.5) {
        return 0.5;
      } else {
        return newZoom;
      }
    } else {
      return newZoom;
    }
  }
}
