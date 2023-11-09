import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class ArtBoardManager {
  PlayerLabCanvas canvas;

  ArtBoardManager({required this.canvas});

  void onScaleStart(ScaleStartDetails details) {
    // index of active layer
    int active = canvas.selectionIndex;
    PlayerLabLayer layer = canvas.layers![active];

    layer.panStart = details.localFocalPoint;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    var currentPosition = details.localFocalPoint;
    var newScale = details.scale;

    int active = canvas.selectionIndex;

    PlayerLabLayer layer = canvas.layers![active];

    if (newScale != 1.0) {
      var zoomDelta = newScale * layer.zoomStart;
      var panDelta = currentPosition - layer.panStart;

      layer.zoom = layer.updateZoom(zoomDelta);
      layer.panDelta = panDelta;
      layer.location = layer.locationPanStart + panDelta;
    } else {
      var panDelta = currentPosition - layer.panStart;

      layer.panDelta = panDelta;
      layer.location = layer.locationPanStart + panDelta;
    }
  }

  void onScaleEnd(ScaleEndDetails details) {
    int active = canvas.selectionIndex;
    PlayerLabLayer layer = canvas.layers![active];

    layer.locationPanStart = layer.locationPanStart! + layer.panDelta;
    layer.panStart = Offset.zero;
    layer.panDelta = Offset.zero;
    canvas.zoom = canvas.updateZoom(canvas.zoom);
    layer.zoomStart = layer.zoom!;
  }

  onTapDown(TapDownDetails details) {
    var position = details.localPosition;

    for (var i = 0; i < canvas.layers!.length; i++) {
      PlayerLabLayer layer = canvas.layers![i];
      double width = (layer.image!.image!.width) * (layer!.zoom ?? 1.0);
      double height = (layer.image!.image!.height) * (layer!.zoom ?? 1.0);
      Rect rect =
          Rect.fromLTWH(layer.location!.dx, layer.location!.dy, width, height);
      if (rect.contains(position)) {
        canvas.selectionIndex = i;
      }
    }
  }

  onControlChange(ControlValueType controlValue){

  }

  PlayerLabLayer get activeLayer {
    int active = canvas.selectionIndex;
    PlayerLabLayer layer = canvas.layers![active];
    return layer;
  }
}
