import 'dart:ui';

import 'package:facts/player_lab/mask.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PlayerLabCanvas {
  List<PlayerLabLayer>? layers;
  double zoom = 1.0;
  Offset pan = Offset.zero;
  int selectionIndex = -1;
  ControlValueTypeName selectedController = ControlValueTypeName.None;
  Mask brushMask = Mask();
  bool usesBrush;

  PlayerLabCanvas(
      {this.layers,
      required this.zoom,
      required this.pan,
      this.usesBrush = false});

  double updateZoom(double newZoom) {
    if (newZoom > 5.5) {
      return 5.5;
    } else if (newZoom < -1.0) {
      return -1.0;
    } else {
      return newZoom;
    }
  }

  @override
  String toString() {
    // return "Pan : $pan\n\nLayers :\n${layers!.map((e) => e).join("\n")} \n";
    return "Zoom : $zoom\n\nLayers :\n${layers!.map((e) => e).join("\n")} \n Mask: \n $brushMask";
  }

  void clickHandler(Offset pointer) {
    for (var i = 0; i < layers!.length; i++) {}
  }

  Future<void> _loadResources() async {
    for (var i = 0; i < layers!.length; i++) {
      var imageData = await rootBundle.load(layers?[i].image?.path ?? "");
      layers?[i].image?.image =
          await decodeImageFromList(imageData.buffer.asUint8List());

      if (layers?[i].image!.shaderPath != null) {
        var program = await FragmentProgram.fromAsset(
            layers?[i].image!.shaderPath ?? "shaders/shader_image.frag");
        layers?[i].image!.shader = program.fragmentShader();
      }
    }
  }

  Future<void> _initializeMask() async {
    await brushMask!.makeWhiteImage();
  }

  Future<void> initialize() async {
    await _loadResources();
    await _initializeMask();
  }

  Future<void> regenerateMask() async {
    await brushMask!.makeImageFromPath();
  }

  bool allowBrush() {
    bool? val = layers?[selectionIndex].allowBrush;
    bool safeVal;
    if (val != null) {
      safeVal = val;
    } else {
      safeVal = false;
    }
    return safeVal;
  }
}
