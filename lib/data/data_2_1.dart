import 'package:facts/game/model/message_popup_screen.dart';
import 'package:facts/game/model/message_result.dart';
import 'package:facts/data/model.dart';
import 'package:facts/player_lab/model/canvas.dart';
import 'package:facts/player_lab/model/comparator.dart';
import 'package:facts/player_lab/model/image.dart';
import 'package:facts/player_lab/model/layer.dart';
import 'package:facts/player_lab/model/layer_config.dart';
import 'package:flutter/animation.dart';
import 'package:image_compare/image_compare.dart';

// the ghost in microwave puzzle

var data = Content(
    type: ContentType.lab,
    labCanvas: [
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p2l1.png', shaderPath: "shaders/contrast.frag"),
            location: const Offset(0, 0),
            controls: [
              ControlValueDoubleRange(
                  value: 1, min: -20, max: 5, label: 'Exposure')
            ]),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p2l2.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
        PlayerLabLayer(
            image: PlayerLabImage(
                path: 'assets/p2l3.png',
                shaderPath: "shaders/shader_image.frag"),
            location: const Offset(0, 0),
            controls: []),
      ], zoom: 1.0, pan: const Offset(0, 0)),
      PlayerLabCanvas(layers: [
        PlayerLabLayer(
            image: PlayerLabImage(
                path: "assets/p2t.png",
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
            title: "ooops", message: "10 people died at the demonstration")));
