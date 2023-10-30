import 'dart:io';

import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/animation.dart';

var data = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/apple.jpeg', shaderPath: "shaders/shader_pan.frag"),
        location: const Offset(0, 0), controls: [
          ControlValueDoubleRange(value: 100, min:0, max:300, label: 'Red'),
          ControlValueDoubleRange(value: 100, min:0, max:300, label: 'Green'),
          ControlValueDoubleRange(value: 100, min:0, max:300, label: 'Blue')
    ]),
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/bottle.png'),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/dash.jpeg"),
        location: const Offset(0, 0), controls: [])
  ], zoom: 1.0, pan: const Offset(0, 0))
]);
