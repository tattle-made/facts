import 'dart:io';

import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:flutter/animation.dart';

var data = Content(type: ContentType.lab, labCanvas: [
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/pzl2_02.png'),
        location: const Offset(0, 0)),
    PlayerLabLayer(
        image: PlayerLabImage(path: 'assets/pzl2_01.png'),
        location: const Offset(0, 0))
  ], zoom: 1.0, pan: const Offset(0, 0)),
  PlayerLabCanvas(layers: [
    PlayerLabLayer(
        image: PlayerLabImage(path: "assets/pzl2_03.png"),
        location: const Offset(0, 0))
  ], zoom: 1.0, pan: const Offset(0, 0))
]);
