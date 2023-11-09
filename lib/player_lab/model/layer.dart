import 'dart:ui';
import 'dart:math';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer_config.dart';

class PlayerLabLayer {
  PlayerLabImage? image;
  late List<ControlValueType> controls;
  List<Point>? path;
  Offset? location = Offset.zero;
  double? zoom = 1.0;

  Offset locationPanStart = Offset.zero;
  Offset panStart = Offset.zero;
  Offset panDelta = Offset.zero;

  double zoomStart = 0.0;

  bool? allowZoom = true;
  bool? allowPan = true;

  PlayerLabLayer({this.image, this.path, this.location, required this.controls, this.allowZoom, this.allowPan});

  @override
  String toString() {
    // return "Location : $location}\nScale2Start: $panStart}, PanDelta:$panDelta";
    return "Zoom : $zoom, ZoomStart: $zoomStart";
  }

  double updateZoom(double newZoom) {
    if (allowZoom!){
      if (newZoom > 2.5) {
        return 2.5;
      } else if (newZoom < 1.0) {
        return 1.0;
      } else {
        return newZoom;
      }
    }else{
      return newZoom;
    }
  }
}
