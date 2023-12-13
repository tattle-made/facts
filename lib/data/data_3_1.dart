import 'dart:io';

import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/message_board/model/Message.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/comparator.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/animation.dart';
import 'package:image_compare/image_compare.dart';

// honey color puzzle

var data = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/honey_1_1.png",
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/honey_1_2.png',
                shaderPath: "shaders/whitebalance.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(value: 0, min: -5, max: 5, label: 'Temp'),
              ControlValueDoubleRange(value: 0, min: -5, max: 5, label: 'Tint')
            ]),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p4t.png",
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: [])
      ], zoom: 1.0, pan: const Offset(0, 0))
    ],
    comparator: Comparator(
      matchAlgorithm: PerceptualHash(),
      match: 0.04,
    ),
    messageResult: MessageResult(
        success: MessagePopupScreen(
            title: "wow", message: "I am surprised with your progress"),
        failure: MessagePopupScreen(
            title: "careful", message: "Stakes are higher now.")));
